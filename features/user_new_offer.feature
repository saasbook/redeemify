Feature: User New Offer

	As a user
	So that I can see the new offer from vendors
    I want to be updated when any vendors change or add their offer

Background:
    Given the following provider codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

Scenario: vendor change offer profile
    
    Given I am on the user login page
    And I have already registered with "facebook" and provider code "12345"
    Then I am signed in with "facebook"
    Then I can see "Offer page"
    Given I press "logout" link
    Given I am on the user login page
    And I have already registered with "facebook" and provider code "12345"
    Then I am signed in with "facebook"
    Then I can see "Offer page"
    Then I can see a different offer profile
