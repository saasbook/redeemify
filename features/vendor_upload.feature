Feature: Vendor Upload (Story 2234)

	As a vendor
	So that I can have codes in the database
	I want to upload my codes

Background:

	Given a vendor "vendor2" and user ID "54321" registered with "facebook"
    Then I am on the user login page

Scenario:
	
	Given I am signed in as a vendor "vendor2" and user ID "54321" with "facebook"
	And I press "upload" link
	Then I should be on the vendor upload page
	And I attach a file with vendor codes inside
	And I fill in "description" with "Lalala"
	And I fill in "instruction" with "My instructions"
	And I press "submit" button
	Then I can see "Codes imported"