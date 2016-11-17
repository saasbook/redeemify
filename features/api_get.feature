Feature: Api GET

  As an api-client
  So that I get a list of vendor codes
  I want to be able to login to my existing account with a third party authentication to see my codes

Scenario: List codes
  Given a vendor "Github" and user ID "1" registered with "facebook"
  Given the following redeemify codes exist:
    | code  | provider   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Amazon   | 01-01-2015 | 01-01-2016 | 1         |    nil  |
  Given the following vendor codes exist:
    | code  | vendor   | created_at | updated_at | vendor_id | user_id |
    | 12345 | Github   | 01-01-2015 | 01-01-2016 | 1         |    nil  |
    | 64321 | Github   | 01-01-2015 | 01-01-2016 | 1         |    1  |
    | 13579 | Github   | 01-01-2015 | 01-01-2016 | 1         |    1  |
    | 97531 | Github   | 01-01-2015 | 01-01-2016 | 1         |    1  |
  When the client requests a list of codes
  Then the response is a list containing three codes
  And one code has the following attributes:
    | attribute | type   | value  |
    | code      | String | 64321 |






