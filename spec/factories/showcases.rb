# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    name "MyString"
    content "MyString"
    publicly_visible false
    account_id 1
  end
end
