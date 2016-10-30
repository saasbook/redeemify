Feature: Enter Provider Code (Story 1b)

    As a user
    So that I can view my offers
    I want to enter the redeemify code

Background:
	Given the following redeemify codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

Scenario: login successful after entering correct serial code
	
	Given I am on the user login page
    Then I am signed in with "facebook"
    And I can see "Redeem Your Code"
	When I fill in "code" with "9998"
	And I press "submit" button
	Then I can see "wrong code!"
	When I fill in "code" with "12345"
	And I press "submit" button
	Then I should be on the offer page