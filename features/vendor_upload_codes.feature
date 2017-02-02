Feature: Uploading vendor codes
  
  As a vendor
  So that I can have codes in the database
  I want to upload my codes

Background:
  
  Given I have signed in through OAuth as a vendor

Scenario: Successful uploading of codes
  
  When I upload an appropriate file with vendor codes
  Then I should be on the vendor page
  And I should see message about successful uploading
  
Scenario: Rejection of invalid vendor codes

   When some vendor codes in my file are invalid
   And I update my set of codes by uploading the file
   Then the invalid vendor codes should not be uploaded
   And I should be notified of rejected codes through file download
   
Scenario: Uploading of file with codes missing (blank file)
  
  When I upload an empty file for new vendor codes
  Then I should be on the vendor upload page
  And I should be alerted of no detected codes

Scenario: Uploading a file of wrong format
  
  When I upload an inappropriate file with vendor codes
  Then I should be on the vendor upload page
  And I should be alerted of inappropriate format for the upload file
  
# Scenario: Unsuccessful uploading of codes
  
#   When I upload inappropriate file
#   Then I should be on the vendor codes upload page
#   And I should see error message
