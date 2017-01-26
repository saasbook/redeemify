Feature: Uploading provider codes
  
  As a provider
  So that I can have codes in the database
  I want to upload my codes
 
Background:
  
  Given I have signed in through OAuth as a provider
  
Scenario: Successful uploading of codes
  
  When I upload an appropriate file with provider codes
  Then I should be on the provider page
  And I should see message about successful uploading
  
Scenario: Failed submission of code duplicates and those in excess of valid length

  When I upload an inappropriate file with provider codes
  Then I should receive a file "2_codes_rejected_at_submission_details.txt"
  And number of uploaded provider codes should be 1

# Scenario: Unsuccessful uploading of codes
  
#   When I upload an inappropriate file
#   Then I should be on the provider codes upload page
#   And I should see error message
