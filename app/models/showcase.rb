# == Schema Information
#
# Table name: showcases
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)     not null
#  content          :string(255)
#  publicly_visible :boolean(1)      default(TRUE), not null
#  account_id       :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  default          :boolean(1)      default(FALSE)
#


class Showcase < ActiveRecord::Base
  attr_accessible :account_id, :content, :name, :publicly_visible, :picture_id, :default
  belongs_to :account
  has_and_belongs_to_many :pictures
  attr_accessible :picture_ids
  validates :name, :presence => true
  default_scope order: 'showcases.created_at DESC'
  before_destroy :check_if_default_showcase_is_being_destroyed

  def check_if_default_showcase_is_being_destroyed
    if (self.default? && self.account.number_of_default_showcases == 1)
      errors.add :account, "You cannot destroy the default showcase of the account"
      errors.blank?
    end
  end
end
