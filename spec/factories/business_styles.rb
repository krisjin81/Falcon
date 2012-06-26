# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business_style do
    sequence :name do |n|
       "Style #{n}"
     end
  end
end
