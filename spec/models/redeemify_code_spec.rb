require 'spec_helper'
require 'rails_helper'

RSpec.describe RedeemifyCode, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = FactoryGirl.build :user
    @provider = FactoryGirl.create :provider, name: 'amazon', provider: 'google'
    @rcode = RedeemifyCode.create! name: 'provider_token', code: '34567'
    @provider.redeemifyCodes << @rcode
  end

  describe "#assign_to" do
    it 'should update user_id, user_name, email attributes' do
      @rcode.assign_to(@user)
      expect(@rcode.user_id).to eq(@user.id)
      expect(@rcode.user_name).to eq(@user.name)
      expect(@rcode.email).to eq(@user.email)
    end
    
    it 'should update provider used_codes and unclaimed_codes attributes' do
      expect{@rcode.assign_to(@user)}.to change{@provider.used_codes}.by(1)
      expect{@rcode.assign_to(@user)}.to change{@provider.unclaimed_codes}.by(-1)
    end    
  end
  
  describe "RedeemifyCode.anonymize" do
    it 'should anonymize user_name, email attributes' do
      @rcode.assign_to @user
      RedeemifyCode.anonymize! @user
      anonymized_token = @provider.redeemifyCodes.find_by code: @rcode.code
      
      expect(anonymized_token.user_name).to eq("anonymous")
      expect(anonymized_token.email).to eq("anonymous@anonymous.com")      
    end
  end  
end
