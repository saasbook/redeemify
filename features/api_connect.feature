




Feature: User Login (Story 2)

  As a client
  So that I get a list of vendor codes
  I want to be able to login to my existing account with a third party authentication to see my offers

  Background:
    Given the following redeemify codes exist:
      | code  | provider   | created_at | updated_at | vendor_id | user_id |
      | 12345 | Amazon     | 01-01-2015 | 01-01-2016 | 1         |    nil  |

  Scenario: successful login after entering valid credentials