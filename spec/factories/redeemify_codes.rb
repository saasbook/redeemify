FactoryGirl.define do
  sequence :code do |n|
    "000#{n}"
  end
  
  factory :redeemify_code do
    code
    user_id nil
  end
end