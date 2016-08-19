Feature: Register New Account

  As a user
  So that I can make a new account
  I want to register my account with developer authentication


  Scenario: login successful after entering correct serial code

    Given I am on the user login page
    When I press "Developer" link
    Then I can see "Redeem Your Code"