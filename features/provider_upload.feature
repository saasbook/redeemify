Feature: Provider Upload 

	As a provider
	So that I can have codes in the database
	I want to upload my codes

Background:

	Given a provider "amazon" exist
    Then I am on the user login page

Scenario:
	
	Given I am signed in as a provider "amazon"
	And I press "upload" link
	Then I should be on the provider upload page
	And I attach a file with redeemify codes inside
	And I fill in "comments" with "test comments"
	Then show me the page
	And I press "submit" button
	Then I can see "Codes imported"
	Then I press "upload" link
	And I attach a file with redeemify codes inside
	And I fill in "comments" with "test comments"
	And I press "submit" button
	Then I can see "Codes imported"