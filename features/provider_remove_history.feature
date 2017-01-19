Feature: Removing the history of the provider actions concerning codes
  
  As a provider
  So that I can be able to delete information about codes management
  I want to clear the history

Background:
  
  Given I have signed in through OAuth as a provider

Scenario: Successful removing of history
  
  When I have uploaded file with provider codes
  Then I should be on the provider page
  When I follow the link to clear history
  Then I should see message about successful removing of history
