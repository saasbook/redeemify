Given /^(?:|I (?:am |have ))(?:logging|signed) in through OAuth as a vendor(?:| "(.*)")$/ do |vendor|
  v = Vendor.find_by_name("#{vendor}") || Vendor.create(name: "GitHub",
        provider: "github", uid: "uid", email: "test@github.com", cash_value: 10)
  visit(root_path)
  disable_test_omniauth()
  set_omniauth_vendor(v)
  click_link("github-auth")
end

Given /^the vendor "(.*)" has registered offers$/ do |vendor|
  v = Vendor.find_by_name("#{vendor}") || Vendor.create(name: "#{vendor}",
        provider: "github", email: "test@vendor.com", cash_value: 10)
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
      File.join(Rails.root, 'features', 'upload-file', 'test.csv'))
  end
    click_button('submit')
end

When /^(?:|I) update my set of codes by uploading the file$/ do
    click_link('upload')
    expect(page).to have_current_path('/vendors/upload_page')
    attach_file('file', 
      File.join(Rails.root, 'features', 'upload-file', 'invalid_codes_test.txt'))
    click_button('submit')
end  

When /^(?:|I) upload an empty file for new vendor codes$/ do
    click_link('upload')
    expect(page).to have_current_path('/vendors/upload_page')
    attach_file('file', 
      File.join(Rails.root, 'features', 'upload-file', 'blank_test.txt'))
    click_button('submit')
end

Then /^number of (\w+) vendor codes should be (\d+)$/ do |attribute, value|
  v = Vendor.find_by_name("GitHub")
  case attribute
    when "uploaded"
      raise "uploaded_codes != #{value}" if v.uploaded_codes != value.to_i
    when "unclaimed"
      raise "unclaimed_codes != #{value}" if v.unclaimed_codes != value.to_i
    when "used"
      raise "used_codes != #{value}" if v.used_codes != value.to_i
    end
end

Then /^the invalid vendor codes should not be uploaded$/ do
  step "number of uploaded vendor codes should be 1"
end

When /^some vendor codes in my file are invalid$/ do
    p = Provider.find_by_name("GitHub")
    file=File.open(File.join(Rails.root, 'features', 'upload-file', 'invalid_codes_test.txt'),"r")
    err_codes=0; codes = []
    file.each_line do |row|
			row = row.gsub(/\s+/, "")
			if row !=  "" &&
			  ( codes.any? {|c| c == row} || VendorCode.find_by(code: row) || row.length > 255 )
			    err_codes += 1
      end
        codes << row
    end
    err_codes.should > 0
end


#Then /^I should receive a file "([^"]*)"$/ do |filename| 
#   page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
#end  


Then /^(?:|I )should see option to log in as a user$/ do
  page.should have_content('Change to user')
end

When /^(?:|I )follow the link to (.*)$/ do |action|
  case action
    when 'switch to user account'
      click_link('change_to_user')
    when 'switch to vendor account'
      click_link('change_to_vendor')
    when 'remove unclaimed codes'
      click_link('remove_unclaimed_codes')
    when 'clear history'
      click_link('clear_history')
    when 'view uploaded codes'
      click_link('view_codes')
    when 'download unclaimed codes'
      click_link('download_unclaimed_codes')
  end
end

Then /^(?:|I )should see message about successful removing of history$/ do
  page.should have_content('History was cleared')
end

And /^(?:|I )should see form to enter the code$/ do
  page.should have_content('Redeem your code!')
end