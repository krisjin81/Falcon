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
#  admin_level            :integer(1)
#  external_user_id       :integer(8)
#  provider               :string(20)
#

class Affiliate < User
  has_one :business_profile

  accepts_nested_attributes_for :business_profile

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :business_profile_attributes

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :bypass_humanizer

  scope :with_profile, includes(:business_profile => [:country, :avatar])

  self.per_page = 10

  # Overrides Affiliate string representation.
  #
  # @return [String] business_name or email.
  #
  def to_s
    if business_profile and business_profile.business_name.present?
      business_profile.business_name
    else
      email
    end
  end
end
