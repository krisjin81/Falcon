# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business_profile do
    business_name       { Forgery::Internet.user_name }
    business_type       { BusinessType.list.sample }
    contact_first_name  { Forgery::Name.first_name }
    contact_last_name   { Forgery::Name.last_name }
    contact_email       { Forgery::Internet.email_address }
    about               { Forgery::LoremIpsum.sentences(5) }
    website             { "http://#{Forgery::Internet.domain_name}" }
    country             { Country.random }

    ignore do
      styles_count 5
      audience_count 1
      age_group_count 2
    end

    after_build do |business_profile, evaluator|
      evaluator.styles_count.times do
        business_profile.styles << Style.random
      end
      evaluator.audience_count.times do
        business_profile.audiences << Audience.random
      end
      evaluator.age_group_count.times do
        business_profile.age_groups << AgeGroup.random
      end
    end
  end
end
