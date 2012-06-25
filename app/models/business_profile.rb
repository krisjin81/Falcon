# == Schema Information
#
# Table name: business_profiles
#
#  id                 :integer(4)      not null, primary key
#  affiliate_id       :integer(4)
#  business_name      :string(50)
#  business_type      :integer(1)
#  style              :integer(1)
#  audience           :integer(1)
#  age_group          :integer(1)
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

  attr_protected :affiliate, :affiliate_id, :created_at, :updated_at

  has_enumeration_for :business_type
  has_enumeration_for :style
  has_enumeration_for :audience
  has_enumeration_for :age_group

  validates :business_name, :presence => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :business_type, :presence => true
  validates :style, :presence => true
  validates :audience, :presence => true
  validates :age_group, :presence => true
  validates :contact_first_name, :presence => true, :length => { :maximum => 50 }
  validates :contact_last_name, :presence => true, :length => { :maximum => 50 }
  validates :contact_email, :presence => true, :length => { :maximum => 255 }
  validates :about, :length => { :maximum => 1000 }, :allow_blank => true
  validates :website, :length => { :maximum => 255 }, :allow_blank => true
end
