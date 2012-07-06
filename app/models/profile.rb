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
  belongs_to :account
  belongs_to :country
  has_enumeration_for :gender, :create_helpers => true
  has_one :avatar, :as => :attachable

  validates :username, :format => /^\w+$/, :allow_blank => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :first_name, :length => { :maximum => 50 }
  validates :last_name, :length => { :maximum => 50 }
  validates :gender, :inclusion => Gender.list, :allow_blank => true

  attr_protected :account, :account_id, :created_at, :updated_at

  accepts_nested_attributes_for :avatar

  NULL_ATTRS = %w( username )
  before_save :nil_if_blank

  # Determines whether username can be edited.
  #
  # @return [Boolean] true if username is editable and false otherwise.
  #
  def username_editable?
    username.blank? or invalid?(:username)
  end

  private

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end
end
