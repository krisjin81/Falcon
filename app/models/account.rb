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

class Account < User
  has_one :profile, :dependent => :destroy
  has_many :blogposts, :dependent => :destroy
  has_many :showcases, :dependent => :destroy

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_accounts, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name =>  "Relationship",
                                   :dependent =>   :destroy
  has_many :followers, through: :reverse_relationships, :source => :follower

  has_many :favorites
  has_many :favorited_pictures,  :through => :favorites, :source => :commentable, :source_type => 'Picture'
  has_many :favorited_showcases, :through => :favotires, :source => :commentable, :source_type => 'Showcase'

  accepts_nested_attributes_for :profile
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes,:username, :free_member_level, :affiliate_member_level, :active
  validates_presence_of :username

  FREE_MEMBER_LEVELS=['New Member','Regular Member','Loyal Member','Style Star','Model/Artist']
  SIGNUP_MEMBER_LEVELS=['New Member'] #this array contains the member levels that a user can choose while signing up

  validates :free_member_level, :presence=> true, :inclusion => FREE_MEMBER_LEVELS
  validates_uniqueness_of :username
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable
  attr_accessor :bypass_humanizer
  before_save :create_default_showcase_if_none_exists
  validate :has_exactly_one_default_showcase

  has_enumeration_for :provider, :create_helpers => true

  scope :with_profile, includes(:profile => [:avatar])
  scope :from_facebook, where(:provider => Provider::FACEBOOK)
  scope :from_twitter, where(:provider => Provider::TWITTER)
  scope :from_google, where(:provider => Provider::GOOGLE)
  scope :by_facebook_id, lambda { |facebook_id| from_facebook.where(:external_user_id => facebook_id) }
  scope :by_facebook_email, lambda { |email| from_facebook.where(:email => email) }
  scope :by_twitter_id, lambda { |twitter_id| from_twitter.where(:external_user_id => twitter_id) }
  scope :by_twitter_email, lambda { |email| from_twitter.where(:email => email) }
  scope :by_google_id, lambda { |google_id| from_google.where(:external_user_id => google_id) }
  scope :by_google_email, lambda { |email| from_google.where(:email => email) }



  self.per_page = 10

  def is_account_active?
    return true if ( self.active == nil || self.active == true )
    return false
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  # Overrides Account string representation.
  #
  # @return [String] username or email.
  #
  def to_s
    if profile and profile.to_s.present?
      profile.to_s
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

  def has_default_showcase?
    number_of_default_showcases == 1
  end

  def can_create_additional_showcases?
    ( self.free_member_level == 'Style Star' || self.free_member_level == 'Model/Artist' )
  end

  def non_default_showcases
    non_default_showcases = []
    self.showcases.each do |showcase|
      if !showcase.default?
        non_default_showcases << showcase
      end
    end
      non_default_showcases
  end

  def active_for_authentication?
    # Comment out the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml

    super && is_account_active?
  end

  class << self
    # Finds user by facebook token or creates a new one.
    #
    # @param access_token [OmniAuth::AuthHash] auth hash.
    #
    # @return [Account] account.
    #
    def facebook_oauth(access_token)
      user_info = access_token.extra.raw_info
      external_user_id = user_info.id
      email = user_info.email
      account = self.by_facebook_id(external_user_id).first || self.by_facebook_email(email).first
      if account.blank?
        account = self.new
        account.email = email
        account.provider = Provider::FACEBOOK
        account.external_user_id = user_info.id
        account.skip_confirmation!
        account.build_profile :first_name => user_info.first_name, :last_name => user_info.last_name
        if user_info.gender.present?
          gender = Gender.enumeration[user_info.gender.to_sym]
          account.profile.gender = gender.first if gender
        end
        account.save
      end
      account
    end

    # Finds user by twitter token or creates a new one.
    #
    # @param access_token [OmniAuth::AuthHash] auth hash.
    #
    # @return [Account] account.
    #
    def twitter_oauth(access_token)
      user_info = access_token.extra.raw_info
      external_user_id = user_info.id
      email = "#{user_info.screen_name}@twitter.com"
      account = self.by_twitter_id(external_user_id).first || self.by_twitter_email(email).first
      if account.blank?
        account = self.new
        account.email = email
        account.provider = Provider::TWITTER
        account.external_user_id = user_info.id
        account.skip_confirmation!
        if user_info.name
          first_name, last_name = user_info.name.split
          account.build_profile :first_name => first_name, :last_name => last_name
        end
        account.save
      end
      account
    end

    # Finds user by twitter token or creates a new one.
    #
    # @param access_token [OmniAuth::AuthHash] auth hash.
    #
    # @return [Account] account.
    #
    def google_oauth(access_token)
      user_info = access_token.extra.raw_info
      external_user_id = user_info.id
      email = user_info.email
      account = self.by_google_id(external_user_id).first || self.by_google_email(email).first
      if account.blank?
        account = self.new
        account.email = email
        account.provider = Provider::GOOGLE
        account.external_user_id = user_info.id
        account.skip_confirmation!
        account.build_profile :first_name => user_info.given_name, :last_name => user_info.family_name
        if user_info.gender.present?
          gender = Gender.enumeration[user_info.gender.to_sym]
          account.profile.gender = gender.first if gender
        end
        account.save
      end
      account
    end
  end

  def default_showcase
    if has_default_showcase?
      self.showcases.each do |showcase|
        if showcase.default == true
          return showcase
        end
      end
    else
      nil
    end
  end


  def create_default_showcase_if_none_exists
    if !has_default_showcase?
      showcase = Showcase.new(:name => "#{self.username}'s Showcase" , :publicly_visible => true, :default=>true )
      showcase.save!
      self.showcases << showcase
    end
  end


  def has_exactly_one_default_showcase
    errors.add(:showcases, "there cannot be more than one default showcase!") if number_of_default_showcases > 1
  end

  def number_of_default_showcases
    default_showcases = []
    self.showcases.each do |showcase|
      if showcase.default == true
        default_showcases << showcase
      end
    end
    default_showcases.count
  end

end
