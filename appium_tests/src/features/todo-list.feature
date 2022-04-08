Feature: Interacting with todo list

    @AddScenario
    Scenario: Add item to todo list
        Given http-server is started with delay
        And the app has started
        And spinner has disappeared
        When I enter the text hello to the text field
        And I tap the button labeled Add
        And I enter the text world to the text field
        And I tap the button labeled Add
        Then item hello is found
        And item world is found

    @AddScenario
    Scenario: Check item on todo list
        Given http-server is started with delay
        And the app has started
        And spinner has disappeared
        When I tap the 3rd checkbox
        Then the text "All done!" is found
