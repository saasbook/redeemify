Feature: Removing provider codes

  As a provider
  So that I do not have expired and unused codes in the database
  I want to be able to remove my codes

Background:
  
  Given the following redeemify codes exist:
    | code  | provider  |
    | 12345 | Amazon    |
    | 13579 | Amazon    |

Scenario: Successful removing of codes
  
  Given I have signed in through OAuth as a provider "Amazon"
  Then number of uploaded provider codes should be 2
  When I follow the link to remove unclaimed codes
  Then number of unclaimed provider codes should be 0
