Feature: Downloading of vendor codes
  
  As a vendor
  So that I can use information for analytical purposes
  I want to be able to download codes
  
Background:
  Given the following vendor codes exist
    | code  | provider      |
    | 12345 | AgileVentures |
    | 54321 | AgileVentures |

Scenario: Downloading of unclaimed codes
  
  Given I have signed in through OAuth as a vendor
  Then I should be on the vendor page
  When I follow the link to download unclaimed codes
  Then I should receive a file "unclaimed_codes.txt"