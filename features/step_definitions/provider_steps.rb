Given /^(?:|I (?:am |have ))(?:logging|signed) in through OAuth as a provider(?:| "(.*)")$/ do |provider|
  p = Provider.find_by_name("#{provider}") || Provider.create(name: "Amazon",
        provider: "amazon", email: "test@amazon.com")
  visit(root_path)
  disable_test_omniauth()
  set_omniauth_provider(p)
  click_link("amazon-auth")
end

When /^(?:|I (?:|have ))upload(?:|ed)(?:| an (in)?appropriate) file(?:| with provider codes)$/ do |inappropriate|
    click_link('upload')
    expect(page).to have_current_path('/providers/upload_page')
  unless inappropriate
    attach_file('file', 
      File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
  else
    attach_file('file', 
      File.join(Rails.root, 'features', 'upload-file', 'invalid_codes_test.txt'))
  end
    click_button('submit')
end

When /^(?:|I) add these codes by uploading the file$/ do
  step "upload an inappropriate file with provider codes"
end

When /^(?:|I) upload an empty file for new provider codes$/ do
    click_link('upload')
    expect(page).to have_current_path('/providers/upload_page')
    attach_file('file', 
      File.join(Rails.root, 'features', 'upload-file', 'blank_test.txt'))
    click_button('submit')
end


Then /^(?:|I )should see message about successful uploading$/ do
  page.should have_content(/(\d+) code(s?) imported/)
end

Then /^I should be alerted of no detected codes$/ do
  page.should have_content "No codes detected! Please check your upload file"
end  
  
Then /number of (\w+) provider codes should be (\d+)$/ do |attribute, value|
  p = Provider.find_by_name("Amazon")
  case attribute
    when "uploaded"
      raise "uploadedCodes != #{value}" if p.uploadedCodes != value.to_i
    when "unclaimed"
      raise "unclaimCodes != #{value}" if p.unclaimCodes != value.to_i
    when "used"
      raise "usedCodes != #{value}" if p.usedCodes != value.to_i
  end
end

Then /^the invalid provider codes should not be uploaded$/ do
  step "number of uploaded provider codes should be 1"
end

When /^some provider codes in my file are invalid$/ do
    p = Provider.find_by_name("Amazon")
    file=File.open(File.join(Rails.root, 'features', 'upload-file', 'invalid_codes_test.txt'),"r")
    err_codes=0; codes = []
    file.each_line do |row|
			row = row.gsub(/\s+/, "")
			if row !=  "" &&
			  ( codes.any? {|c| c == row} || RedeemifyCode.find_by(code: row) || row.length > 255 )
			    err_codes += 1
      end
        codes << row
    end
    err_codes.should > 0
end

Then /^I should receive a file "([^"]*)"$/ do |filename| 
   page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end  

Then /^I should be notified of rejected codes through file download$/ do
  filename = "_rejected_at_submission_details.txt"
  page.response_headers['Content-Disposition'].should include "filename="
  page.response_headers['Content-Disposition'].should include #{filename}
end

When /^(?:|I )follow the logout link$/ do
  click_link('logout')
end
