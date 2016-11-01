Feature: Vendor Remove History

	As a vendor/provider
	So that I can keep track the information about the codes that I deleted
    I want to see the information of removing code activities shown in the history

Background:
	
	Given a vendor "Github" and user ID "12345" registered with "facebook"
    Given a provider "Amazon" exist

Scenario: 
        
    Given I am on the user login page
    Then I am signed in as a vendor "Github" and user ID "12345" with "facebook"
    And I press "upload" link
    Then I should be on the vendor upload page
    And I attach a file with vendor codes inside
    And I press "submit" button
    Then I can see "Codes imported"
    When I press "clear-history" link
    Then I can see "Cleared History"

Scenario:
    
    Given I am on the user login page
    Then I am signed in as a provider "Amazon"
    And I press "upload" link
    Then I should be on the provider upload page
    And I attach a file with redeemify codes inside
    And I fill in "comments" with "test comments"
    And I press "submit" button
    Then I can see "Codes imported"
    When I press "clear-history" link
    Then I can see "Cleared History"
