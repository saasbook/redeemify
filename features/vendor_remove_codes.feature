Feature: Removing codes for Vendor
  
  As a vendor
  So that I do not have expired and unused codes in the database
  I want to be able to remove my codes

Background:
  
  Given the following vendor codes exist
    | code  | vendor  |
    | 12345 | GitHub  |
    | 13579 | GitHub  |

Scenario: Successful removing of codes
  
  Given I have signed in through OAuth as a vendor "GitHub"
  Then number of uploaded vendor codes should be 2
  When I follow the link to remove codes
  Then number of unclaimed vendor codes should be 0
