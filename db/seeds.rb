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

   # Add myself as a Vendor User to admininster the Amazon $10 vendor codes
   # Other developers feel free to create a PR to add yourself and some vendor codes
   User.create!(provider: "Amazon", uid: 123, name: "matthew.r.lindsey@gmail.com")
   Vendor.create!(name: "www.amazon.com", uid: 123, provider: "Amazon", description: "$10 AWS Credit",
                  website: "amazon.com", helpLink: "amazon.com/help", cashValue: "$10")
   VendorCode.create(code: 'xP78vvjk3K', vendor_id: 1)
   VendorCode.create(code: 'yF35ovem3V', vendor_id: 1)
   VendorCode.create(code: 'zL92pcje3M', vendor_id: 1)

 end
