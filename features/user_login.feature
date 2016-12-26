Feature: User Login (Story 2)

	As a user
	So that I can log in to my account
	I want to be able to login to my existing account with a third party authentication to see my offers

Background:
	Given the following redeemify codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 23456 | Github     | 02-01-2015 | 21-01-2016 | 2         |    nil  |
    | 34567 | Github     | 02-01-2015 | 21-01-2016 | 2         |    nil  |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |
    | 45678 | Github     | 02-01-2015 | 21-01-2016 | 2         |    nil  |


Scenario: successful login after entering valid credentials
	
	Given I am on the user login page
	And I have already registered with "facebook" and redeemify code "12345"
	And the provider "unclaimCodes" should be "0"
	And the provider "usedCodes" should be "1"
    When I am signed in with "facebook"
	Then I should see "Total Offer Value"

Scenario: unsuccessful login after entering invalid credentials, redirected back to home page

	Given I am on the user login page
	And I entered invalid credentials with "Facebook"
	Then I should see "Sign-in"

