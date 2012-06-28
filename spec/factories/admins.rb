# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email             { Forgery::Internet.email_address }
    password          { Forgery::Basic.password }
    admin_level       { AdminLevel.list.sample }
    association       :admin_profile, :factory => :admin_profile, :strategy => :build
  end
end
