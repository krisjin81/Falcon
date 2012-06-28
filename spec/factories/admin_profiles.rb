# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_profile do
    username    { Forgery::Internet.user_name }
    first_name  { Forgery::Name.first_name }
    last_name   { Forgery::Name.last_name }
  end
end
