Feature: Provider Form

	As a provider
	So that I can login to resend the codes
	I want to login using my account and see a page with an upload form

Background:

	Given a provider "amazon" exist
	Then I am on the user login page

Scenario:
	
	Given I am signed in as a provider "amazon"
	And I press "upload" link
	Then I should be on the provider upload page