Feature: Switching to user account
  
  As a vendor
  So that I can log in as a user using the same account
  I want to switch to user account

Background:
  Given I have signed in through OAuth as a vendor
  Then I should be on the vendor page

Scenario: Switching to the user account
  When I follow the link to switch to user account
  Then I should be on the new session page
  And I should see form to enter the code

Scenario: Switching to the vendor account from the new session page
  When I follow the link to switch to user account
  Then I should be on the new session page
  When I follow the link to switch to vendor account
  Then I should be on the vendor page

Scenario: Redirecting to the offers page when user entered valid redeemify code
  When I follow the link to switch to user account
  Then I should be on the new session page
  When I enter valid redeemify code
  Then I should be on the offers page
  
Scenario: Switching to the vendor account from the offers pag
  When I follow the link to switch to user account
  Then I should be on the new session page
  When I enter valid redeemify code
  Then I should be on the offers page
  When I follow the link to switch to vendor account
  Then I should be on the vendor page