FactoryGirl.define do
  factory :vendor do
    name "Amazon"
    provider "Amazon Oauth"
    expiration "MyExpiration"
    description "MyDescription"
    instruction "MyInstruction"
    helpLink "MyHelpLink"
    cashValue "$10"
  end
end