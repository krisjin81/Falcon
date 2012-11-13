class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id
  belongs_to :follower, :class_name => "Account"
  belongs_to :followed, :class_name => "Account"

  validates :follower_id, :presence => true
  validates :followed, :presence => true
end
# == Schema Information
#
# Table name: relationships
#
#  id          :integer(4)      not null, primary key
#  follower_id :integer(4)
#  followed_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

