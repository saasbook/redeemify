require 'spec_helper'
require 'rails_helper'

RSpec.describe RedeemifyCode, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"

  describe "#assign_to" do
  before :each do
    @user = FactoryGirl.create :user, {name: 'Joe', email: 'joe@email.com'}
    @provider = Provider.create! name: 'amazon', provider: 'google'
    @rcode = RedeemifyCode.create! name: 'provider_token', code: '34567'
    @provider.redeemifyCodes << @rcode

  end
    it 'updates user_id, user_name, email attributes' do
      @rcode.assign_to(@user)
      expect(@rcode.user_id).to eq(@user.id)
      expect(@rcode.user_name).to eq(@user.name)
      expect(@rcode.email).to eq(@user.email)
    end
    
    it 'updates provider usedCodes and unclaimCodes attributes' do
      expect{@rcode.assign_to(@user)}.to change{@provider.usedCodes}.by(1)
      expect{@rcode.assign_to(@user)}.to change{@provider.unclaimCodes}.by(-1)
    end    

  end
end
