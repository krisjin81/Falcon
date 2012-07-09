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
end
