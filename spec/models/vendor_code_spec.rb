require 'spec_helper'
require 'rails_helper'

RSpec.describe VendorCode, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"

  describe "#assign_to" do
  before :each do
    @user = FactoryGirl.create :user, {name: 'Joe', email: 'joe@email.com'}
    @vendor = Vendor.create! name: 'amazon', uid: '98765', provider: 'amazon'
    @vcode = VendorCode.create! code: '34567'
    @vendor.vendorCodes << @vcode

  end
    it 'updates user_id, user_name, email attributes' do
      @vcode.assign_to(@user)
      expect(@vcode.user_id).to eq(@user.id)
      expect(@vcode.user_name).to eq(@user.name)
      expect(@vcode.email).to eq(@user.email)
    end
    
    it 'updates vendor usedCodes and unclaimCodes attributes' do
      expect{@vcode.assign_to(@user)}.to change{@vendor.usedCodes}.by(1)
      expect{@vcode.assign_to(@user)}.to change{@vendor.unclaimCodes}.by(-1)
    end    

  end
end
