When /^(?:|I )enter (in)?valid redeemify code$/ do |invalid|
  p = Provider.create(name: 'Amazon', provider: 'amazon',
        email: 'test@amazon.com')
  p.redeemifyCodes.create(code: '12345')
  if invalid
    fill_in('code', with: 'abcde')
  else
    fill_in('code', with: '12345')
  end
  click_button('submit')
end

Given /the following redeemify codes? exist/ do |redeemify_codes_table|
  p1 = Provider.create!(:name => 'Amazon', :provider => 'amazon',
        :email => 'test@amazon.com')
  p2 = Provider.create!(:name => 'Github', :provider => 'google',
        :email => 'test@github.com')
  p1_numberOfCodes = 0
  p2_numberOfCodes = 0
  redeemify_codes_table.hashes.each do |redeemify_code|
    if redeemify_code["provider"] == 'Amazon'
      p1.redeemifyCodes.create!(code: redeemify_code["code"],
        name: redeemify_code["provider"], provider_id: p1.id)
      p1_numberOfCodes += 1
    else  
      p2.redeemifyCodes.create!(code: redeemify_code["code"],
        name: redeemify_code["provider"], provider_id: p2.id)
      p2_numberOfCodes += 1
    end  
  end
  p1.update_attribute(:uploaded_codes, p1.uploaded_codes + p1_numberOfCodes)
  p1.update_attribute(:unclaimed_codes, p1.unclaimed_codes + p1_numberOfCodes)
  p2.update_attribute(:uploaded_codes, p2.uploaded_codes + p2_numberOfCodes)
  p2.update_attribute(:unclaimed_codes, p2.unclaimed_codes + p2_numberOfCodes)
end