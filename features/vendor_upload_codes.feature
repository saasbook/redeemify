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
  
Scenario: Failed submission of code duplicates and those in excess of valid length

  When I upload an inappropriate file with vendor codes
  Then I should receive a file "2_codes_rejected_at_submission_details.txt"
  And number of uploaded vendor codes should be 1
  

# Scenario: Unsuccessful uploading of codes
  
#   When I upload inappropriate file
#   Then I should be on the vendor codes upload page
#   And I should see error message
