# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    email     { Forgery::Internet.email_address }
    password  { Forgery::Basic.password }
    confirmed_at { Time.now.utc }                 # skip confirmation
  end
end
