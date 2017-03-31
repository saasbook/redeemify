FactoryGirl.define do
  factory :vendor do
    name "Amazon"
    uid "12345"
    provider "amazon_oauth2"
    email "example@amazon.com"
    history "History"
    cashValue "$10"
    expiration "01/27/2015"
    description "AWS credit"
    instruction "Follow the page and redeem credit"
    helpLink "https://aws.amazon.com/uk/awscredits/"
  end
end