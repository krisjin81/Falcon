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

  attr_protected :created_at, :updated_at, :attachable_id, :attachable_type

  mount_uploader :image, PictureUploader

  validates :image, :presence => true
  validates :title, :presence => true
  validates :dressing_tips, :presence => true

  #has_attached_file :image, :styles => { :thumb => "100x100>", :preview => "200x200>" },
  #                  :url => "/system/avatars/:id/:style/:filename",
  #                  :default_url => "/missing.png"
  #
  #validates_attachment_size :image, :in => 0..20.megabytes
end
