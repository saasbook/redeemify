Feature: Vendor Login as User

	As a vendor
	So that I can login as a user using the same account
    I want to choose to login as a vendor or user

Background:
	
	Given a vendor "Github" and user ID "12345" registered with "facebook"
    And this vendor also registered as a user

Scenario: 
        
    Then I am on the user login page
    And I am signed in as a vendor "Github" and user ID "12345" with "facebook"
    Then I can see "Login as a vendor"
    And I can see "Login as a user"
    When I click "vendor-login"
    Then I should be on the vendor page
    When I go back
    And I click "Login as a user"
    Then I should be on the view offer page