# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

raise "I refuse to destroy the production database!" if Rails.env.production?

# SuperUser
AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

case Rails.env
 when "development"
   Provider.create!(name: "Amazon")

   RedeemifyCode.create!(code: "zyxwv", provider_id: 1)
   RedeemifyCode.create!(code: "yyyyy", provider_id: 1)
   RedeemifyCode.create!(code: "zzzzz", provider_id: 1)

   # Add a Vendor to administer the Amazon $10 vendor codes
   Vendor.create!(name: "www.amazon.com", provider: "amazon", description: "$10 AWS Credit",
                  website: "amazon.com", helpLink: "amazon.com/help", cashValue: "$10")
   VendorCode.create(code: 'xP78vvjk3K', vendor_id: 1)
   VendorCode.create(code: 'yF35ovem3V', vendor_id: 1)
   VendorCode.create(code: 'zL92pcje3M', vendor_id: 1)

   # Add myself as a "Google" Provider to test Provider code uploads
   # Other developers feel free to create a PR to add yourself
   # Note that you must also modify config/application.yml to contain the GOOGLE_KEY and GOOGLE_SECRET for your
   # Google+ account as described at https://developers.google.com/+/web/api/rest/oauth
   Provider.create!(name: "Google", provider: "google_oauth2", email: "matthew.r.lindsey@gmail.com")
   Provider.create!(name: "Google", provider: "google_oauth2", email: "kiko.pineda@gmail.com")
   # Provider.create!(name: "Google", provider: "google_oauth2", email: "khlipun@gmail.com")
   Provider.create!(name: "Google", provider: "google_oauth2", email: "uzzsen@gmail.com")
   
   # Add myself as a "Amazon" Vendor to test Vendor code uploads
   # Note that you must also modify config/application.yml to contain the AMAZON_KEY and AMAZON_SECRET for your Amazon
   # account as in http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys
   # Vendor.create!(name: "Amazon", provider: "amazon_oath2", email: "matthew.r.lindsey@gmail.com",  description: "AWS Testing",
   #                website: "matthewrlindsey.org", helpLink: "matthewrlindsey.org/help", cashValue: "$8")
   Vendor.create!(name: "Alexander", provider: "google_oauth2", uid: "uid", cashValue: "$7", email: "khlipun@gmail.com")
end
