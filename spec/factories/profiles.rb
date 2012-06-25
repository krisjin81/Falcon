# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    username    { Forgery::Internet.user_name }
    birth_date  { (rand(50) + 10).years.ago }
    gender      { Gender.list.sample }
    first_name  { male? ? Forgery::Name.male_first_name : Forgery::Name.female_first_name }
    last_name   { Forgery::Name.last_name }
    association :country, :factory => :country, :strategy => :create
  end
end
