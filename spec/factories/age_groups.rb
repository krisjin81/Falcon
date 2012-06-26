# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :age_group do
    sequence :name do |n|
       "Age Group #{n}"
    end
  end
end
