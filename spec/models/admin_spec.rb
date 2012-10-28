# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  type                   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  admin_level            :string(255)
#  external_user_id       :string(50)
#  provider               :string(20)
#  username               :string(255)
#  free_member_level      :string(255)
#  affiliate_member_level :string(255)
#  active                 :boolean(1)
#

require 'spec_helper'

describe Admin do
  it "should be possible to create admin with valid admin level" do
    view_only_admin = Admin.create(:email => "view@gmail.com", :password=>"hello12345", :admin_level => "User Admin" )
    view_only_admin.save!

    view_only_admin.should be_valid
  end

  it "Should not be able to create admin with invalid admin level" do
    invalid_admin = Admin.create(:email => "something@foo.com", :password => "hello12345", :admin_level => "foobar" )
    invalid_admin.should_not be_valid
  end
end
