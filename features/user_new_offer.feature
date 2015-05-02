Feature: User New Offer

	As a user
	So that I can see the new offer from vendors
    I want to be updated when any vendors change or add their offer

Background:
    Given the following provider codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

    And a vendor "Github" and user ID "2" registered with "facebook"

    And the following vendor codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 43143 | Github     | 01-01-2015 | 01-01-2016 | 1         |    nil  |
    | 23233 | Github     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

Scenario: vendor change offer profile
    
    Given I am on the user login page
    And I have already registered with "facebook" and provider code "12345"
    Then I am signed in with "facebook"
    Then I can see "Github"
    Given I press "logout" link

    Then a vendor "Heroku" and user ID "3" registered with "facebook"

    Given I am on the user login page
    Then I am signed in with "facebook"
    Then I can see "Heroku"
    Given I press "logout" link

    Then the following vendor codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | asdad | Heroku     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

    Given I am on the user login page
    Then I am signed in with "facebook"
    Then I can see "Heroku"