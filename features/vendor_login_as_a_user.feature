Feature: Vendor log in as a user
  
  As a vendor
  So that I can log in as a user using the same account
  I want to login as a user

Background:
  
  When I have signed in through OAuth as a vendor
  Then I should see option to log in as a user

# Scenario: Successful logging in as a user
  
#   When I follow the link to log in as a user
#   Then I should be on the new session page
#   And I should see "Redeem your code!"
#   When I enter valid redeemify code
#   Then I should be on the offers page
#   When I follow the link to log in as a vendor
#   Then I should be on the vendor page
