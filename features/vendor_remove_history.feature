Feature: Removing history of the vendor actions concerning codes
  
  As a vendor
  So that I can be able to delete information about codes management
  I want to clear the history

Background:
  
  Given I have signed in through OAuth as a vendor

Scenario: Successful removing of history
  
  When I have uploaded file with vendor codes
  Then I should be on the vendor page
  When I follow the link to clear history
  Then I should see message about successful removing of history
