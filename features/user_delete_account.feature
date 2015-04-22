Feature: User Delete Account

	As a user
    So that I can remove all my information from Redeemify app
    I want to delete my account

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
    And I have updated the vendor profile
    And I can see "Number of codes remaining: 4"
    When I press "remove-unclaimed-codes" link
    Then I can see "Number of codes remaining: 0"
