Feature: Vendor Upload (Story 2234)

	As a vendor
	So that I can have codes in the database
	I want to upload my codes

Scenario: 

	Given that I am a vendor
	And I am on the vendor landing page
	And I follow "Upload"
	Then I should be on the vendor upload form page
	And I should see the form fields

Scenario:
	
	Given that I am on the vendor landing page
	And I fill in file_name with "My File"
	And I fill in description with "Lalala"
	And I fill in instructions with "My instructions"
	And I fill in expiration date with "01-01-2016"
	And I press Submit
	Then I should be on the vendor landing page
	And I should see "Successful upload"