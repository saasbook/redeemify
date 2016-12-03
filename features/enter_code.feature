Feature: Enter Provider Code (Story 1b)

  As a user
  So that I can view my offers
  I want to enter the redeemify code

Background:

  Given the following redeemify codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

	Given I am on the user login page
  When I am signed in with "facebook"
  Then I should see "Redeem your code!"

Scenario: loggin in fails when code is incorrect
  
  When I enter code "9998"
  Then I should see "Please enter a valid redeemify code"
  
Scenario: login is successful when entering a valid code
  
  When I enter code "12345"
  Then I should be on the offer page