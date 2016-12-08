require 'spec_helper'

describe CouponCode do
  before :each do
    @cc = CouponCode.new(20)
  end
  it 'generates valid code' do
    CouponCode.decode(@cc.generate).should be_a_kind_of Hash
  end
  it 'is probabilistically hard to guess valid codes' do
    valid = @cc.generate
    expect((1..10000).map { |val| CouponCode.decode(valid-val) }.compact).to be_empty 
    expect((1..10000).map { |val| CouponCode.decode(valid+val) }.compact).to be_empty 
  end
end

    
