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

  validates :username, :format => /^\w+$/, :allow_blank => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :first_name, :length => { :maximum => 50 }
  validates :last_name, :length => { :maximum => 50 }
  validates :birth_date, :presence => true
  validates :country_id, :presence => true
  validates :gender, :inclusion => Gender.list, :allow_blank => true

  attr_protected :account, :account_id, :created_at, :updated_at
end
