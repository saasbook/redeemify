FactoryGirl.define do
  factory :user do
    name "MyString"
    email { FFaker::Internet.email }
  end
end