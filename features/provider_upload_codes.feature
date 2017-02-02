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
  
Scenario: Rejection of invalid provider codes

   When some provider codes in my file are invalid
   And I add these codes by uploading the file
   Then the invalid provider codes should not be uploaded
   And I should be notified of rejected codes through file download
   
Scenario: Uploading a file with codes missing (blank file)
  
  When I upload an empty file for new provider codes
  Then I should be on the provider upload page
  And I should be alerted of no detected codes
   
Scenario: Uploading a file of wrong format
  
  When I upload an inappropriate file with provider codes
  Then I should be on the provider upload page
  And I should be alerted of inappropriate format for the upload file
  
  
# Scenario: Unsuccessful uploading of codes
  
#   When I upload an inappropriate file
#   Then I should be on the provider codes upload page
#   And I should see error message
