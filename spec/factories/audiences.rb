# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audience do
    sequence :name do |n|
       "Audience #{n}"
    end
  end
end
