FactoryGirl.define do
  factory :redeemifyCode do
    provider
    name "MyString"
    code "MyString"
    user_id 1
    provider_id 1
  end

end