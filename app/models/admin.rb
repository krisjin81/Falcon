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
#

class Admin < User
  has_one :admin_profile, :dependent => :destroy

  accepts_nested_attributes_for :admin_profile

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin_profile_attributes, :admin_level

  validates :admin_level, :presence => true, :inclusion => AdminLevel.list

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_enumeration_for :admin_level, :create_helpers => true

  scope :with_profile, includes(:admin_profile)

  self.per_page = 10

  # Overrides Admin string representation.
  #
  # @return [String] username or email.
  #
  def to_s
    email
  end
end
