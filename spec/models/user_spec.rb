require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  
  subject { @user }
  
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  it { should be_valid }
  
  describe "#anonymize" do
    before { @user.anonymize! }
    it "should have 'anonymous' name, email, provider" do
      expect(@user.name).to eq("anonymous")
      expect(@user.email).to eq("anonymous@anonymous.com")
      expect(@user.provider).to eq("anonymous")
    end
  end  
end