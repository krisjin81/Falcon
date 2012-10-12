class Showcase < ActiveRecord::Base
  attr_accessible :account_id, :content, :name, :publicly_visible, :picture_id
  belongs_to :account
  has_and_belongs_to_many :pictures
  attr_accessible :picture_ids
  validates :name, :presence => true
  validates_presence_of :publicly_visible
  default_scope order: 'showcases.created_at DESC'
end
