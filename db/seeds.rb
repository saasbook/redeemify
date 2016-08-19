# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')


case Rails.env
when "development"
  User.create!(provider: "Amazon", uid: 111, name: "Amazon.com")

  Provider.create!(name: "Amazon.com")
  ProviderCode.create!(code: "zyxwv")

  Vendor.create!(name: "VendorOne", uid: 111, provider: "github", description: "Github (1 mth free micro)",
    website: "google.com", helpLink: "google.com/help", cashValue: 25)
  VendorCode.create(code: 'xP78vvjk3V', vendor_id: 111, user_id: nil, name: "GitHub Micro", user_name: nil)
end

