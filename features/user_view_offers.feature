Feature: Vendors' offers for the users
  
  As a user
  So that I can redeem offers from vendors
  I want to see information about each offer
  
Background:
  
  Given the vendor "GitHub" has registered offers
  And the vendor "CodeClimate" has registered offers

Scenario: User is seeing offers from all vendors
  
  When I have signed in through OAuth as a user
  Then I should be on the offers page
  And I should see "GitHub"
  And I should see "CodeClimate"
