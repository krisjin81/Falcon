# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    name  { Forgery::Address.country }
    iso2  { name[0,2] }
    iso3  { name[0,3] }
  end
end
