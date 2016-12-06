FactoryGirl.define do
  factory :user do
    email "you@domain.com"
    password "password"
    password_confirmation "password"
  end
end