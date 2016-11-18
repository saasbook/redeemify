Feature: Api GET

  As an api-client
  So that I get a list of vendor codes
  I want to be able to login to my existing account with a third party authentication to see my codes

  Scenario: List codes
    Given a vendor "Github" and user ID "1" registered with "facebook"
    Given the following redeemify codes exist:
      | code  | provider   | created_at | updated_at | vendor_id | user_id |
      | zyxwv | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |
    Given the following vendor codes exist:
      | code  | vendor | upload     | expiry_date | code_type | user_id |
      | 12345 | Github | 01-01-2015 | 01-01-2016  | free_repo | 1       |
    When I send and accept JSON
    And I send a GET request for "/users" with the following:
      | id | 1  |
    Then the response status should be "200"
    And the JSON response should have "code" with a length of 1
