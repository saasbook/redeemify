Feature: User Delete Account

	As a user
    So that I can remove all my information from Redeemify app
    I want to delete my account

Background:
    Given the following provider codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

Scenario: vendor change offer profile
    
    Given I am on the user login page
    And I have already registered with "facebook" and provider code "12345"
    Then I am signed in with "facebook"
    When I press "delete-account" link
    Then my user should be deleted
 