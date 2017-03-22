Feature: Viewing provider codes
  
  As a provider
  So that I want to be confident that file with codes processed well
  I want to be able to view my codes

Background:
  
  Given the following redeemify codes exist:
    | code  | provider  |
    | 12345 | Amazon    |
    | 54321 | Amazon    |

Scenario: Viewing of uploaded codes
  
  Given I have signed in through OAuth as a provider "Amazon"
  Then I should be on the provider page
  When I follow the link to view uploaded codes
  Then I should see "12345"
  And I should see "54321"