Feature: Provider login
  
  As a provider
  So that I should be able to manage my codes
  I want to log in through OAuth

Scenario: Successful logging in and out
  
  When I am logging in through OAuth as a provider
  Then I should be on the provider page
  When I follow the logout link
  Then I should be on the user login page
