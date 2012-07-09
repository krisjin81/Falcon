# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :style do
    sequence :name do |n|
       "Style #{n}"
    end
  end
end
