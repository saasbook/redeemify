FactoryGirl.define do
  factory :provider do
    name "Google"
    history "History"
    provider "google_oauth2"
    email "example@google.com"
  end
end
