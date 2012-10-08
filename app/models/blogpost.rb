class Blogpost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  validates :content, :length => { :maximum => 5000 }
  validates :account_id, presence: true
  default_scope order: 'blogposts.created_at DESC'
end
