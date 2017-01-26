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

Then /^(?:|I )should see message about successful uploading$/ do
  page.should have_content(/(?:\d+\s+c)ode(s?) imported/)
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

Then /^I should receive a file "([^"]*)"$/ do |filename| 
   page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end  

When /^(?:|I )follow the logout link$/ do
  click_link('logout')
end
