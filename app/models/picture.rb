# == Schema Information
#
# Table name: pictures
#
#  id              :integer(4)      not null, primary key
#  attachable_type :string(255)
#  attachable_id   :integer(4)
#  title           :string(255)
#  dressing_tips   :text
#  brands          :string(255)
#  cost            :string(255)
#  where_to_buy    :string(255)
#  gender          :integer(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  image           :string(255)
#

class Picture < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_and_belongs_to_many :styles

  has_enumeration_for :gender, :with => ClothingGender, :create_helpers => true

  attr_protected :created_at, :updated_at, :attachable_id, :attachable_type

  mount_uploader :image, PictureUploader

  validates :attachable, :presence => true
  validates :image, :presence => true
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :style_ids, :presence => true
  validates :dressing_tips, :presence => true, :length => { :maximum => 1000 }
  validates :brands, :length => { :maximum => 255 }, :allow_blank => true
  validates :cost, :length => { :maximum => 255 }, :allow_blank => true
  validates :where_to_buy, :length => { :maximum => 255 }, :allow_blank => true
  validates :gender, :presence => true, :inclusion => ClothingGender.list
end
