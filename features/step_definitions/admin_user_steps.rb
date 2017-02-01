Given /^(?:|I have )already registered as an admin$/ do
  AdminUser.create!(:email => 'admin@example.com', :password => 'password',
    :password_confirmation => 'password')
end

Given /^(?:|I have )signed in as an admin$/ do
  fill_in("admin_user_email", :with => "admin@example.com")
  fill_in("admin_user_password", :with => "password")
  click_button("commit")
end
