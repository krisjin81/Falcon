# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :affiliate do
    email             { Forgery::Internet.email_address }
    password          { Forgery::Basic.password }
    confirmed_at      { Time.now.utc }  # skip confirmation
    association       :business_profile, :factory => :business_profile, :strategy => :build
    bypass_humanizer  true
  end
end
