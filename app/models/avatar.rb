# == Schema Information
#
# Table name: avatars
#
#  id                 :integer(4)      not null, primary key
#  image_file_name    :string(255)
#  image_file_size    :integer(4)
#  image_content_type :string(255)
#  image_updated_at   :datetime
#  attachable_type    :string(255)
#  attachable_id      :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Avatar < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  attr_protected :created_at, :updated_at

  has_attached_file :image, :styles => { :thumb => "100x100>" },
                    :url => "/system/avatars/:id/:style/:filename",
                    :default_url => "/missing.png"

  validates_attachment_size :image, :in => 0..5.megabytes
end
