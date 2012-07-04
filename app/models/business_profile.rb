# == Schema Information
#
# Table name: business_profiles
#
#  id                 :integer(4)      not null, primary key
#  affiliate_id       :integer(4)
#  business_name      :string(50)
#  business_type      :integer(1)
#  contact_first_name :string(50)
#  contact_last_name  :string(50)
#  contact_email      :string(255)
#  about              :text
#  website            :string(255)
#  country_id         :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class BusinessProfile < ActiveRecord::Base
  belongs_to :affiliate
  belongs_to :country
  has_and_belongs_to_many :business_styles
  has_and_belongs_to_many :audiences, :join_table => :business_profiles_audiences
  has_and_belongs_to_many :age_groups, :join_table => :business_profiles_age_groups
  has_one :avatar, :as => :attachable

  attr_protected :affiliate, :affiliate_id, :created_at, :updated_at

  accepts_nested_attributes_for :avatar

  has_enumeration_for :business_type

  validates :business_name, :format => /^\w+$/, :presence => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :business_type, :presence => true
  validates :business_style_ids, :presence => true
  validates :audience_ids, :presence => true
  validates :age_group_ids, :presence => true
  validates :contact_first_name, :presence => true, :length => { :maximum => 50 }
  validates :contact_last_name, :presence => true, :length => { :maximum => 50 }
  validates :contact_email, :presence => true, :length => { :maximum => 255 }, :format => Devise.email_regexp
  validates :about, :length => { :maximum => 1000 }, :allow_blank => true
  validates :website, :length => { :maximum => 255 }, :allow_blank => true

  # Determines whether business name can be edited.
  #
  # @return [Boolean] true if business name is editable and false otherwise.
  #
  def business_name_editable?
    business_name.blank? or invalid?(:business_name)
  end
end
