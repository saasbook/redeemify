Feature: Enter Provider Code (Story 1b)

    As a user
    So that I can view my offers
    I want to enter the provider code


Scenario: login successful after entering correct serial code

    Given I am on the new page
    And I can see "Signed in!"
	When I fill in "code" with "9283084"
	And I press "Submit"
	Then I should be on the offer page