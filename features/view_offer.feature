Feature: User View Offer (Story 3)

    As a user
    So that I can redeem my offers
    I want to see my code, instructions, total value and expiration date of my offers

Background:

    Given a vendor "Github" and user ID "1" with cash value "10" registered with "facebook"
    And a vendor "CodeClimate" and user ID "2" with cash value "8" registered with "facebook"
    Given the following redeemify codes exist:
    | code  | provider | created_at | updated_at | user_id |
    | 12345 | Amazon   | 01-01-2015 | 01-01-2016 |         |

    Given the following vendor codes exist:
    | code  | vendor   | created_at | updated_at | user_id |
    | 54321 | Github   | 01-01-2015 | 01-01-2016 |    1    |
    | 64321 | Github   | 01-01-2015 | 01-01-2016 |         |
    | 13579 | Github   | 01-01-2015 | 01-01-2016 |    1    |
    | 97531 | Github   | 01-01-2015 | 01-01-2016 |    1    |

Scenario:
    
    Given I am on the user login page
    And I have already registered with "facebook" and redeemify code "12345"
    Given I am signed in with "facebook"
    Then I should see "12345"
    And I should see "Github"
    And I should see "64321"
    And I should see "CodeClimate"
    And I should see "Total Offer Value: $18.0"
