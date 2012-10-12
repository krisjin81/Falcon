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
#  original_image  :string(255)
#  filter          :string(20)
#  formatted_image :string(255)
#  style           :string(255)
#

class Picture < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_and_belongs_to_many :styles
  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable
  has_and_belongs_to_many :showcases
  attr_accessible :showcase_ids
  accepts_nested_attributes_for :showcases

  has_enumeration_for :gender, :with => ClothingGender, :create_helpers => true

  attr_protected :created_at, :updated_at, :attachable_id, :attachable_type

  mount_uploader :original_image, PictureUploader
  mount_uploader :formatted_image, PictureUploader

  validates :attachable, :presence => true
  validates :original_image, :presence => true
  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :dressing_tips, :presence => true, :length => { :maximum => 1000 }
  validates :brands, :length => { :maximum => 255 }, :allow_blank => true
  validates :cost, :length => { :maximum => 255 }, :allow_blank => true
  validates :where_to_buy, :length => { :maximum => 255 }, :allow_blank => true
  validates :gender, :presence => true, :inclusion => ClothingGender.list

  scope :latest, order('created_at DESC').limit(10)

  # Gets formatted image if filter was applied or original image otherwise.
  #
  def image
    if formatted_image.present?
      formatted_image
    else
      original_image
    end
  end

  # Determines whether specified account is owner of picture.
  #
  # @param account [Account] account to check.
  #
  # @return [Boolean] true if specified account is owner of image and false otherwise.
  #
  def is_owner?(account)
    attachable == account.profile
  end

  # Overrides Picture string representation.
  #
  # @return [String] username or email.
  #
  def to_s
    title
  end
end
