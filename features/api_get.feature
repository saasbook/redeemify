Feature: Api GET

  As an API client
  So that I can display a vendor code in another location
  I would like access to a vendor code

  Scenario: List codes
    Given a vendor "Github" and user ID "1" registered with "facebook"
    Given the following redeemify codes exist:
      | code  | provider   | created_at | updated_at | vendor_id | user_id |
      | zyxwv | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |
    Given the following vendor codes exist:
      | code  | vendor | upload     | expiry_date | code_type | user_id |
      | 12345 | Github | 01-01-2015 | 01-01-2016  | free_repo | 1       |
    When I send and accept JSON
    And I send a GET request for "/api/users" with the following:
      | id | 1  |
    Then the response status should be "401"
    #Response will be 401 unauthorized, until proper auth is added.  Then use the following:
    #And the JSON response should have "code" with a length of 1
