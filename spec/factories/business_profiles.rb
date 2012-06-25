# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business_profile do
    business_name       { Forgery::Internet.user_name }
    business_type       { BusinessType.list.sample }
    style               { Style.list.sample }
    audience            { Audience.list.sample }
    age_group           { AgeGroup.list.sample }
    contact_first_name  { Forgery::Name.first_name }
    contact_last_name   { Forgery::Name.last_name }
    contact_email       { Forgery::Internet.email_address }
    about               { Forgery::LoremIpsum.sentences(5) }
    website             { "http://#{Forgery::Internet.domain_name}" }
    association         :country, :factory => :country, :strategy => :create
  end
end
