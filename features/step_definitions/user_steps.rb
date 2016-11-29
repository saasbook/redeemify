require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "omniauth"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Then /^show me the page$/ do
  save_and_open_page
end

Given /the following vendor codes exist/ do |vendor_codes_table|
  numberOfCodes = 0
  v = 0
  vendor_codes_table.hashes.each do |code|
    v = Vendor.find_by_name(code['vendor'])
    v.vendorCodes.create!(:code => code["code"], :name => v.name, :vendor => v)
    numberOfCodes = numberOfCodes + 1
  end
  if v != 0
    v.update_attribute(:uploadedCodes, v.uploadedCodes + numberOfCodes)
    v.update_attribute(:unclaimCodes, v.unclaimCodes + numberOfCodes)
  end
end

Given /I have already registered as an admin/ do
  AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
end

Given /I am signed in as an admin/ do
  fill_in("admin_user_email", :with => "admin@example.com")
  fill_in("admin_user_password", :with => "password")
  click_button("commit")
end

Given /the following redeemify codes exist/ do |redeemify_codes_table|
  p = Provider.create!(:name => 'Amazon', :provider => 'facebook', :email => 'amazon@amazon.com')
  numberOfCodes = 0
  redeemify_codes_table.hashes.each do |code|
    p.redeemifyCodes.create!(:code => code["code"], :name=> p.name, :provider => p)
    numberOfCodes = numberOfCodes + 1
  end
  p.update_attribute(:uploadedCodes, p.uploadedCodes + numberOfCodes)
  p.update_attribute(:unclaimCodes, p.unclaimCodes + numberOfCodes)
end

Given /a provider "([^"]*)" exist$/ do |provider_name|
  p = Provider.create!(:name => provider_name, :provider => "facebook", :email => "amazon@amazon.com")
end

Given /I am signed in as a provider "([^"]*)"$/ do |provider_name|
  p = Provider.find_by_name(provider_name)
  name = p.name
  provider = p.provider
  email = p.email
  disable_test_omniauth()
  set_omniauth_provider(:name => name, :provider => provider, :email=> email)
  click_link("#{provider.downcase}-auth")
end

Given /the following vendors exist/ do |vendors_table|
  vendors_table.hashes.each do |vendor|
    Vendor.create(vendor)
  end
end

Then /the vendor "([^"]*)" should be "([^"]*)"$/ do |attribute, value|
  if attribute == "uploadedCodes"
    v = Vendor.find_by_name("Github")
    if v.uploadedCodes != value.to_i
      raise "uploadedCodes value is not the same with test value"
    end
  elsif attribute == "unclaimCodes"
    v = Vendor.find_by_name("Github")
    if v.unclaimCodes != value.to_i
      raise "unclaimCodes value is not the same with test value"
    end
  end
    
end

Then /the provider "([^"]*)" should be "([^"]*)"$/ do |attribute, value|
  if attribute == "uploadedCodes"
    p = Provider.find_by_name("Amazon")
    if p.uploadedCodes != value.to_i
      raise "uploadedCodes value is not the same with test value"
    end
  elsif attribute == "unclaimCodes"
    p = Provider.find_by_name("Amazon")
    if p.unclaimCodes != value.to_i
      raise "unclaimCodes value is not the same with test value"
    end
  end
    
end

Then /my user should be deleted$/ do
  u = User.find_by_name("foo")
  if u
    raise "User is not deleted"
  end
end

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

And /^I have updated the vendor profile/ do
  click_link("update-profile")
  fill_in("cashValue", :with => "1")
  fill_in("expiration", :with => "11/11/2015")
  fill_in("description", :with => "description")
  fill_in("helpLink", :with => "www")
  fill_in("instruction", :with => "instruction")
  click_button("submit")
end

And /^(?:|I )have never registered$/ do
  disable_test_omniauth()
end

Given /^I am signed in with "([^"]*)"$/ do |provider|
  set_omniauth()
  click_link("#{provider.downcase}-auth")
end

Given /^I am signed in as a vendor "([^"]*)" and user ID "([^"]*)" with "([^"]*)"$/ do |name, uid, provider|
  disable_test_omniauth()
  set_omniauth_vendor(:name => name, :uid => uid, :provider => provider, :email=> 'test@gmail.com')
  click_link("#{provider.downcase}-auth")
end

Given /^a vendor "(.*?)" and user ID "(.*?)" registered with "(.*?)"$/ do |name, uid, provider|
  #@vendor1 = create(:vendor, :name => name, :uid => uid, :provider => provider)
  vendor = Vendor.new
  vendor.name = name
  vendor.uid = uid
  vendor.provider = provider
  vendor.email = 'test@gmail.com'
  vendor.cashValue = '1'
  vendor.save
end

And /^I have already registered with "([^"]*)" and redeemify code "([^"]*)"$/ do |provider, code|
  set_omniauth()
  click_link("#{provider.downcase}-auth")
  fill_in("code", :with => code)
  click_button("Submit")
  click_link("logout")
end


And /^I entered invalid credentials with "([^"]*)"$/ do |provider|
  set_invalid_omniauth()
  click_link("#{provider.downcase}-auth")
end

Given /^(?:|I )should see "([^"]*)"$/ do |words|
  if page.respond_to? :should
    page.should have_content(words)
  else
    assert page.has_content?(text)
  end
end

When /^(?:|I )press "([^"]*)" link$/ do |link|
  if link.eql? "Log out"
    click_link("logout")
  else
    click_link(link)
  end
end

When /^(?:|I )press "([^"]*)" button$/ do |button|
  click_button(button)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.respond_to? :should
  current_path.should == path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

And /^I attach a file with vendor codes inside$/ do
  attach_file('file', File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
end

And /^I attach a file with redeemify codes inside$/ do
  attach_file('file', File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
end

Given(/^I have updated the provider home$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
Then(/^I have updated the vendor home$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When /^(?:|I )enter code "(.*)"$/ do |redeemify_code|
  steps %Q{
	  When I fill in "code" with "#{redeemify_code}"
	  And I press "submit" button
  }
end
