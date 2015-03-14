Feature: User Login (Story 2)

	As a user
	So that I can log in to my account
	I want to be able to login to my existing account with a third party authentication to see my offers

Scenario: successful login after entering valid credentials
	
	Given I am on the user login page
	And I have already registered with "Facebook"
    Then I am signed in with "Facebook"
	Then I can see "Offer page"

Scenario: unsuccessful login after entering invalid credentials, redirected back to home page

	Given I am on the user login page
	And I entered invalid credentials with "Facebook"
	Then I can see "Authentication failed, please try again."

