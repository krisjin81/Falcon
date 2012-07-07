# == Schema Information
#
# Table name: avatars
#
#  id              :integer(4)      not null, primary key
#  attachable_type :string(255)
#  attachable_id   :integer(4)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  image           :string(255)
#

class Avatar < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  attr_protected :created_at, :updated_at

  mount_uploader :image, AvatarUploader

  #has_attached_file :image, :styles => { :thumb => "100x100>" },
  #                  :url => "/system/avatars/:id/:style/:filename",
  #                  :default_url => "/missing.png"
  #
  #validates_attachment_size :image, :in => 0..5.megabytes
end
