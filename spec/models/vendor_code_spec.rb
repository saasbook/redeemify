require 'spec_helper'
require 'rails_helper'

RSpec.describe VendorCode, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
before do
    @user = FactoryGirl.build :user
    (1..5).each do |i| 
      @vendor = FactoryGirl.create :vendor, name: "vendor#{i}", uid: "0000#{i}", provider: 'amazon'
      @vendor.vendorCodes << VendorCode.create(code: "000#{i}")
    end  
end

  describe "#assign_to" do
  before :each do
    @vCode = @vendor.vendorCodes.first
  end
    it 'updates user_id, user_name, email attributes' do
      @vCode.assign_to(@user)
      expect(@vCode.user_id).to eq(@user.id)
      expect(@vCode.user_name).to eq(@user.name)
      expect(@vCode.email).to eq(@user.email)
    end
    
    it 'updates vendor usedCodes and unclaimCodes attributes' do
      @vCode.assign_to(@user)
      expect{@vCode.assign_to(@user)}.to change{@vendor.usedCodes}.by(1)
      expect{@vCode.assign_to(@user)}.to change{@vendor.unclaimCodes}.by(-1)
    end    

  end
  
  describe "VendorCode.anonymize_all" do
    it "should anonymize user_name and email attributes" do
      VendorCode.all.each {|vc| vc.assign_to @user}
      VendorCode.anonymize_all! @user
      
      expect(VendorCode.all.all? {|vc| vc.email == "anonymous@anonymous.com"}).to be true
      expect(VendorCode.all.all? {|vc| vc.user_name == "anonymous"}).to be true
    end
  end
end
