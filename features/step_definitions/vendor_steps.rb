Given /^(?:|I (?:am |have ))(?:logging|signed) in through OAuth as a vendor(?:| "(.*)")$/ do |vendor|
  v = Vendor.find_by_name("#{vendor}") || Vendor.create(name: "GitHub",
        provider: "github", email: "test@github.com", cashValue: "$10")
  visit(root_path)
  disable_test_omniauth()
  set_omniauth_vendor(v)
  click_link("github-auth")
end

Given /^the vendor "(.*)" has registered offers$/ do |vendor|
  v = Vendor.find_by_name("#{vendor}") || Vendor.create(name: "#{vendor}",
        provider: "github", email: "test@vendor.com", cashValue: "$10")
  disable_test_omniauth()
  set_omniauth_vendor(v)
  visit(root_path)
  click_link("github-auth")
  click_link("logout")
end

When /^(?:|I (?:|have ))upload(?:|ed)(?:| an (in)?appropriate) file(?:| with vendor codes)$/ do |inappropriate|
    click_link('upload')
    expect(page).to have_current_path('/vendors/upload_page')
  unless inappropriate
    attach_file('file',
      File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
  else
    attach_file('file',
      File.join(Rails.root, 'features', 'upload-file', 'invalid_codes_test.txt'))
  end
    click_button('submit')
end

Then /^number of (\w+) vendor codes should be (\d+)$/ do |attribute, value|
  v = Vendor.find_by_name("GitHub")
  case attribute
    when "uploaded"
      raise "uploadedCodes != #{value}" if v.uploadedCodes != value.to_i
    when "unclaimed"
      raise "unclaimedCodes != #{value}" if v.unclaimCodes != value.to_i
    when "used"
      raise "usedCodes != #{value}" if v.usedCodes != value.to_i
    end
end

#Then /^I should receive a file "([^"]*)"$/ do |filename| 
#   page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
#end  


Then /^(?:|I )should see option to log in as a user$/ do
  page.should have_content('Login as a user')
end

When /^(?:|I )follow the link to (.*)$/ do |action|
  case action
    when 'log in as a user'
      click_link('user-login')
    when 'log in as a vendor'
      click_link('vendor-login')
    when 'remove codes'
      click_link('remove-unclaimed-codes')
    when 'clear history'
      click_link('clear-history')
  end
end

Then /^(?:|I )should see message about successful removing of history$/ do
  page.should have_content('Cleared History')
end