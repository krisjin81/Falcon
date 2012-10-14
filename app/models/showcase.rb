class Showcase < ActiveRecord::Base
  attr_accessible :account_id, :content, :name, :publicly_visible, :picture_id, :default
  belongs_to :account
  has_and_belongs_to_many :pictures
  attr_accessible :picture_ids
  validates :name, :presence => true
  validates_presence_of :publicly_visible
  default_scope order: 'showcases.created_at DESC'
  before_destroy :check_if_default_showcase_is_being_destroyed

  def check_if_default_showcase_is_being_destroyed
    if (self.default? && self.account.number_of_default_showcases == 1)
      errors.add :account, "You cannot destroy the default showcase of the account"
      errors.blank?
    end
  end
end
