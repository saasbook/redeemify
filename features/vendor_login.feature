Feature: Vendor Login (Story 4)

	As a provider/vendor
	So that I can login to resend the codes
	I want to login using my account and see a page with an upload form

Background:

	Given a vendor "vendor1" and user ID "12345" registered with "facebook"

Scenario: successful login after entering valid credentials

	Given I am on the user login page
	Then I am signed in as a vendor "vendor1" and user ID "12345" with "facebook"
	Then I should be on the vendor page

Scenario: succesful logout after logged in

	Given I am on the user login page
	Then I am signed in as a vendor "vendor1" and user ID "12345" with "facebook"
	Then I press "Log out" link
	Then I can see "Signed out!"

