Given /^the following vendor codes? exist$/ do |vendor_codes_table|
  v = Vendor.create(name: "GitHub", provider: "github",
    email: "test@github.com", cashValue: "$10")
  v_numberOfCodes = 0
  vendor_codes_table.hashes.each do |vendor_code|
    v.vendorCodes.create(code: vendor_code["code"])
    v_numberOfCodes += 1
  end
  v.update_attribute(:uploadedCodes, v.uploadedCodes + v_numberOfCodes)
  v.update_attribute(:unclaimCodes, v.unclaimCodes + v_numberOfCodes)
end
