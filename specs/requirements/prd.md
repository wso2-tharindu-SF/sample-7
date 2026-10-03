# sample-7 — PRD

## Problem Statement

A consumer that wants a single summary number — the average score across a catalog of
scored records — today has to fetch every record itself and compute the aggregate by
hand. There is no endpoint that hands back the computed average directly, and no way to
exercise how such an endpoint behaves when the underlying catalog is empty versus full
without manually tampering with the data source.

## Solution

Two backend services work together. Service2 holds a catalog of scored records and can
be switched between serving its full fixed catalog and serving an empty one. Service1
asks Service2 for the current catalog and returns the average score across it, rounded
down to a whole number. The same averaging logic runs no matter which catalog Service2
is currently serving.

## Actors

- **API Consumer** — any external caller that requests the average score from Service1.
Access is open; no sign-in is required.
- **Operations Engineer** — an internal operator who switches Service2 between full mode
and empty mode through an internal-only operations endpoint. This endpoint is never
reachable by an API Consumer.

## User Stories

1. As an API Consumer, I want to request the average score of the current catalog, so
 that I get the aggregate figure without fetching and computing it myself.
2. As an API Consumer, I want the average returned as a whole number, so that the result
 is unambiguous and easy to consume.
3. As an API Consumer, I want a request to a path Service1 does not serve to return a
 structured 404 body, so that I can distinguish "no such endpoint" from other
 failures.
4. As an Operations Engineer, I want to switch Service2 between full mode and empty
 mode through an internal operations endpoint, so that I can control which catalog
 Service2 serves without exposing that control to any API Consumer.

## Product Decisions

- **Catalog data**: Service2's full mode serves exactly this fixed, seeded catalog:
- **Starting mode**: Service2 starts in full mode.
- **Mode switch**: Service2 exposes an internal operations endpoint, reachable only by
the Operations Engineer and never by an API Consumer, that switches it between full
mode (the fixed catalog above) and empty mode (no records).
- **Averaging**: Service1 computes the average as the sum of every record's score
divided by the number of records, discarding any remainder. Against the full catalog
this average is 35.
- **One computation path**: the same averaging computation runs for whichever catalog
Service2 is currently serving — there is no separate path or separate result per
catalog.
- **Logging**: both Service1 and Service2 log how many records they handled per
request.
- **Unmatched paths**: a request to a path Service1 does not serve returns a structured
404 body.
- **Access**: Service1's average endpoint is open access — no sign-in is required to
call it.
- **Contract shape — Service1**: Service1's OpenAPI contract documents exactly one
response on its average endpoint: the successful average. No 4xx or 5xx response is
documented on that endpoint. The structured 404 above applies only to paths outside
that contract — i.e. paths Service1 does not serve.
- **Contract shape — both services**: neither service's OpenAPI contract documents an
empty-catalog variant, an alternative response, or an optional field on the
average/catalog endpoints. Service2's empty mode is a fault from Service1's
perspective, not a documented alternative response shape.

## Out of Scope

- What Service1 returns when Service2's catalog is empty. No story, decision,
assumption, acceptance criterion, or error shape covers that case in this version —
not a computed value, not a default, and not an error response.
- Any authentication, authorization, or user-account model for API Consumers.
- Any catalog content, record, or mode beyond the fixed full catalog and the empty
catalog described above.
- Any user interface. Both services are APIs only.

## Open Questions

None at this time.