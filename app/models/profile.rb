# == Schema Information
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  account_id :integer(4)
#  username   :string(50)
#  first_name :string(50)
#  last_name  :string(50)
#  birth_date :date
#  country_id :integer(4)
#  gender     :integer(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Profile < ActiveRecord::Base
  DEFAULT_BIRTH_DATE = Date.new(1980, 1, 1)

  belongs_to :account
  belongs_to :country
  has_one :avatar, :as => :attachable
  has_many :pictures, :as => :attachable
  has_many :comments, :foreign_key => :author_id
  has_many :likes

  has_enumeration_for :gender, :create_helpers => true

  validates :username, :format => /^\w+$/, :allow_blank => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :first_name, :length => { :maximum => 50 }
  validates :last_name, :length => { :maximum => 50 }
  validates :gender, :inclusion => Gender.list, :allow_blank => true

  attr_protected :account, :account_id, :created_at, :updated_at

  accepts_nested_attributes_for :avatar

  NULL_ATTRS = %w( username )
  before_save :nil_if_blank

  scope :by_unique_id, lambda { |unique_id| where('username = ? OR id = ?', unique_id, unique_id) }

  # Determines whether username can be edited.
  #
  # @return [Boolean] true if username is editable and false otherwise.
  #
  def username_editable?
    username.blank? or invalid?(:username)
  end

  # Gets profile full name.
  #
  def full_name
    [first_name, last_name].join(" ")
  end

  # Overrides Account string representation.
  #
  # @return [String] username or email.
  #
  def to_s
    username || full_name
  end

  # Gets user unique identifier.
  #
  def unique_id
    username || id
  end

  private

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end
end
