Feature: Downloading of provider codes
  
  As a provider
  So that I can use information for analytical purposes
  I want to be able to download codes
  
Background:
  Given the following redeemify codes exist
    | code  | provider  |
    | 12345 | Amazon    |
    | 54321 | Amazon    |

Scenario: Downloading of unclaimed codes
  
  Given I have signed in through OAuth as a provider
  Then I should be on the provider page
  When I follow the link to download unclaimed codes
  Then I should receive a file "unclaimed_codes.txt"