Feature: Provider Withdraw Code

	As a provider
	So that I do not have expired and unused codes in the database
	I want to be able to remove my codes

Background:
    Given the following redeemify codes exist:

    | code  | provider | upload     | expiry_date | code_type |
    | 12345 | Amazon   | 01-01-2015 | 01-01-2016  | free_repo |
    | 54321 | Amazon   | 01-01-2015 | 01-01-2016  | free_repo |

Scenario: 
        
    Then I am on the user login page
    Given I am signed in as a provider "Amazon"
    Then the provider "uploadedCodes" should be "2"
    When I press "Download And Remove Unclaimed Codes" link
    Then the provider "unclaimCodes" should be "0"