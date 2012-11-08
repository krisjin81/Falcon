# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  body             :string(1000)
#  author_id        :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => Profile.name

  validates :commentable, :presence => true
  validates :author, :presence => true
  validates :body, :presence => true, :length => { :maximum => 1000 }

  attr_accessible :body
  attr_accessible :author
  attr_accessible :created_at

  scope :descending_by_created_at, order('created_at DESC')

  def set_author(profile)
    self.author = profile
    self
  end
end
