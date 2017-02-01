Logging in as a provider

Tasks:

1. Add 'user_role' attribute for the 'User', 'Provider', and 'Vendor' models

2. Add 'uid' attribute for the 'Provider' model

3. Implement scenario 'Unsuccessful uploading of codes'
		* in ProvidersController#import2 add restrictions for the file type

4. Implement without JS (including bar chart)

5. Delete duplicated buttons

6. 'Upload New Codes'

		* what is the purpose of comments?
		* what is the purpose of uploading codes on a separate page?
		* does it make sense to preview codes before submitting?
 
7. 'Download And Remove Unclaimed Codes'

		* doesn't work without JS
		* raises an error after second clicking
		* does it make sense to divide on two functions?
		* bar chart should reflect changes

8. History and Comments

		* what is the purpose of tracking actions?
		* what is the purpose of comments?

9. New useful features from the provider perspective
  
  * preview of codes before uploading
  * review of uploaded codes
  * comprehensive statistics

Logging in as a vendor

Tasks:

1. All of the above

2. 'Login as a User'

	* what is the purpose?
	* when logging in as a user, one vendor code has been used
	* scenario temporarily commented out:
	    Validation failed: Uid can't be blank (ActiveRecord::RecordInvalid)
        ./app/controllers/vendors_controller.rb:86:in `change_to_user'

3. 'Update Your Profile'

	* define required fields
			cashValue