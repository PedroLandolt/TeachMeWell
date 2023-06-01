Feature: Comment
  A comment should be added when we input text in the description field, input a number in the rating field
  and click on the submit button. The comment should be added to the list of comments.

  Scenario: Add a comment
    Given I am at a teacher's page
    When I input "This is a comment" in the description field
    And I input "5" in the rating field
    And I click on the submit button
    Then I should see "This is a comment" in the list of comments with the rating of 5

  Scenario: Add invalid comment
    Given I am at a teacher's page
    When I input "This is a comment" in the description field
    And I input "6" in the rating field
    And I click on the submit button
    Then I should see "O valor do Rating deve ser um número entre 0 e 5!" in the screen
