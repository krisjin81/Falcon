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
    association         :country, :factory => :country, :strategy => :create

    ignore do
      business_styles_count 5
      audience_count 1
      age_group_count 2
    end

    after_build do |business_profile, evaluator|
      evaluator.business_styles_count.times do
        business_profile.business_styles << Factory.create(:business_style)
      end
      evaluator.audience_count.times do
        business_profile.audiences << Factory.create(:audience)
      end
      evaluator.age_group_count.times do
        business_profile.age_groups << Factory.create(:age_group)
      end
    end
  end
end
