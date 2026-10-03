Feature: Unmatched paths

  @story-3
  Rule: A request to a path Service1 does not serve returns a structured 404 body

    @negative
    Scenario: Requesting a path Service1 does not serve
      Given Service1 is running
      When Alex the API Consumer requests the path "/unknown-path" from Service1
      Then Alex receives a structured 404 error body
