Feature: Logging in for the user
  
  As a user
  So that I can view my offers
  I want to enter redeemify code

Background:
  
  Given I am on the user login page
  When I am logging in through OAuth as a user
  Then I should be on the new session page

Scenario: Successful logging in
  
  When I enter valid redeemify code
  Then I should be on the offers page
  And I should see "Your Redeemify Code"
  
Scenario: Unsuccessful logging in
  
  When I enter invalid redeemify code
  Then I should be on the offers page
  And I should see "Please enter a valid redeemify code"
