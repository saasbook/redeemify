Feature: Deleting the user account
  
  As a user
  So that I can remove all my information from the redeemify app
  I want to delete my account

Background:
  
  When I have signed in through OAuth as a registered user
  Then I should be on the offers page
  And I should see option to delete account

Scenario: Successful deletion
  
  When I delete account
  Then I should be on the user login page
  And I should see message about successful account deletion
  And I should not have a possibility to log in with the same redeemify code
