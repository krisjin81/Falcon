# == Schema Information
#
# Table name: blogposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)     not null
#  account_id :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#


class Blogpost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :account
  validates :content, :length => { :maximum => 5000 }
  validates :account_id, presence: true
  default_scope order: 'blogposts.created_at DESC'

  has_many :comments, :as => :commentable

  def to_s
    "\"#{self.account.username}\""
  end


end
