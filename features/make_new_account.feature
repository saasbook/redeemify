Feature: Make New Account (Story 1a)

    As a user
    So that I can make a new account
    I want to register my account with third party authentication


Scenario: login successful after entering correct serial code

    Given I am on the user login page
	When I press "Amazon"
	Then I should be on the Facebook login page