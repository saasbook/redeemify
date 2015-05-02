Feature: Vendor Withdraw Code

	As a vendor
	So that I do not have expired and unused codes in the database
	I want to be able to remove my codes

Background:
	
	Given a vendor "Github" and user ID "12345" registered with "facebook"
        
    And the following vendor codes exist:

    | code  | vendor | upload     | expiry_date | code_type |
    | 12345 | Github | 01-01-2015 | 01-01-2016  | free_repo |
    | 54321 | Github | 01-01-2015 | 01-01-2016  | free_repo |
    | 13579 | Github | 01-01-2015 | 01-01-2016  | free_repo |
    | 97531 | Github | 01-01-2015 | 01-01-2016  | free_repo |

Scenario: 
        
    Then I am on the user login page
    Then I am signed in as a vendor "Github" and user ID "12345" with "facebook"
    Then show me the page
    And I have updated the vendor profile
    Then the vendor "uploadedCodes" should be "4"
    When I press "remove-unclaimed-codes" link
    Then the vendor "unclaimCodes" should be "0"
