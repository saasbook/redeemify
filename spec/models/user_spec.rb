require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  
  subject { @user }
  
  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  it { should be_valid }
end