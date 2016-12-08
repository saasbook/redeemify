require 'rails_helper'

RSpec.describe Vendor, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'sets correct cash value (#cashValue)' do
    vendor = FactoryGirl.create(:vendor)
    expect(vendor.cashValue).not_to eq("0.00")
  end

  it '#cashValue' do
    vendor = FactoryGirl.create(:vendor)
    expect(vendor.cashValue).to eq("$10")
  end

end
