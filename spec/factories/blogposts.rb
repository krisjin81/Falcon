# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blogpost do
    content "MyString"
    user_id 1
  end
end
