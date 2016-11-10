require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should respond_to(:auth_token) }

  it { should validate_uniqueness_of(:auth_token) }
end