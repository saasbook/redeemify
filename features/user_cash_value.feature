Feature: User Cash Value

	As a user
	So that I can see the total value of my current offers
	I want to login to my account

Background:
	
	Given a vendor "Github" and user ID "12345" registered with "facebook"
        
    And the following vendor codes exist:

    | code  | vendor | upload     | expiry_date | code_type | cash_value |
    | 12345 | Github | 01-01-2015 | 01-01-2016  | free_repo | 40		 |
    | 54321 | Github | 01-01-2015 | 01-01-2016  | free_repo | 40		 |
    | 13579 | Github | 01-01-2015 | 01-01-2016  | free_repo | 40    	 |
    | 97531 | Github | 01-01-2015 | 01-01-2016  | free_repo | 40		 |

Scenario:
	
	Given I am on the user login page
    And I have already registered with "facebook"
    Given I am signed in with "facebook"
    Then I can see total value "$40"
