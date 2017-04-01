Given /^the following vendor codes? exist$/ do |vendor_codes_table|
  v = Vendor.create(name: "GitHub", provider: "github",
    email: "test@github.com", cash_value: 10)
  v_numberOfCodes = 0
  vendor_codes_table.hashes.each do |vendor_code|
    v.vendorCodes.create(code: vendor_code["code"])
    v_numberOfCodes += 1
  end
  v.update_attribute(:uploaded_codes, v.uploaded_codes + v_numberOfCodes)
  v.update_attribute(:unclaimed_codes, v.unclaimed_codes + v_numberOfCodes)
end
