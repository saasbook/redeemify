Feature: Viewing vendor codes
  
  As a vendor
  So that I want to be confident that file with codes processed well
  I want to be able to view my codes

Background:
  
  Given the following vendor codes exist
    | code  | vendor            |
    | 12345 | AgileVentures     |
    | 54321 | AgileVentures     |

Scenario: Viewing of uploaded codes
  
  Given I have signed in through OAuth as a vendor "AgileVentures"
  Then I should be on the vendor page
  When I follow the link to view uploaded codes
  Then I should see "12345"
  And I should see "54321"