Feature: Average score

  @story-1 @story-2
  Rule: The average score is the sum of every record's score divided by the record count, discarded to a whole number

    Scenario: Averaging the full catalog
      Given the catalog is in full mode
      When Alex the API Consumer requests the average score from Service1
      Then the response reports an average of 35
