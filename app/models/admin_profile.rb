# == Schema Information
#
# Table name: admin_profiles
#
#  id         :integer(4)      not null, primary key
#  admin_id   :integer(4)
#  username   :string(50)
#  first_name :string(50)
#  last_name  :string(50)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class AdminProfile < ActiveRecord::Base
  belongs_to :admin

  validates :username, :format => /^\w+$/, :allow_blank => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :first_name, :length => { :maximum => 50 }
  validates :last_name, :length => { :maximum => 50 }

  attr_accessible :username, :first_name, :last_name
end
