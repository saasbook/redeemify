Feature: Vendor Login as User

	As a vendor
	So that I can login as a user using the same account
    I want to choose to login as a vendor or user

Background:
	
	Given a vendor "Github" and user ID "12345" registered with "facebook"
    And the following provider codes exist:
    | code  | provider | upload     | expiry_date | code_type |
    | 12345 | Amazon   | 01-01-2015 | 01-01-2016  | free_repo |


Scenario: 
        
    Then I am on the user login page
    And I am signed in as a vendor "Github" and user ID "12345" with "facebook"
    And I have updated the vendor profile
    Then I can see "Login as a user"
    When I press "user-login" link
    And I can see "Redeem Your Code"
    When I fill in "code" with "12345"
    And I press "submit" button
    Then I can see "Total Offer Value"
    And I press "vendor-login" link
    Then I can see "Number of Codes Uploaded"