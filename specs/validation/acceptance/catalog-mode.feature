Feature: Catalog mode switching

  @story-4
  Rule: Service2 starts in full mode, serving its fixed catalog

    Scenario: The catalog on startup
      Given Service2 has just started
      When Priya the Operations Engineer requests the current catalog from Service2
      Then the catalog has 10 records

  @story-4
  Rule: An Operations Engineer can switch Service2 between full mode and empty mode through its internal operations endpoint

    Scenario: Switching to empty mode
      Given Service2 is in full mode
      When Priya the Operations Engineer switches Service2 to empty mode
      Then Service2's catalog has no records

    Scenario: Switching back to full mode
      Given Service2 is in empty mode
      When Priya the Operations Engineer switches Service2 to full mode
      Then Service2's catalog has 10 records
