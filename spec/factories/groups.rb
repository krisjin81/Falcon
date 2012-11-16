# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "MyString"
    open_subscription false
    community_group false
    member_limit 1
    owner_id 1
  end
end
