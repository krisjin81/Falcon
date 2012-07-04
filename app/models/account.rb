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

class Account < User
  has_one :profile, :dependent => :destroy

  accepts_nested_attributes_for :profile

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  attr_accessor :bypass_humanizer

  scope :with_profile, includes(:profile => [:country, :avatar])
  scope :from_facebook, where(:provider => SocialNetwork::FACEBOOK)
  scope :by_facebook_id, lambda { |facebook_id| from_facebook.where(:external_user_id => facebook_id) }

  self.per_page = 10

  # Overrides Account string representation.
  #
  # @return [String] username or email.
  #
  def to_s
    if profile and profile.username.present?
      profile.username
    else
      email
    end
  end

  # Determines whether password should be present. It can be blank if user sign up with oauth.
  #
  # @return [Boolean] true if when account password should be present and false otherwise.
  #
  def password_required?
    self.provider.blank?
  end

  class << self
    # Finds user by facebook token or creates a new one.
    #
    # @param access_token [OmniAuth::AuthHash] auth hash.
    #
    # @return [Account] account.
    #
    def find_for_facebook_oauth(access_token)
      user_info = access_token.extra.raw_info
      account = Account.by_facebook_id(user_info.id).first
      if account.nil?
        account = self.find_by_email(user_info.email) || Account.new(:email => user_info.email)
        account.provider = access_token.provider
        account.external_user_id = user_info.id
        account.skip_confirmation!
        account.save
      end
      account
    end
  end
end
