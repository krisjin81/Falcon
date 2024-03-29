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
#  cover_picture_id :integer(4)
#


class Showcase < ActiveRecord::Base
  attr_accessible :account_id, :content, :name, :publicly_visible, :picture_id, :default
  belongs_to :account
  has_and_belongs_to_many :pictures
  attr_accessible :picture_ids, :cover_picture_id

  has_many :invitees
  has_many :accounts, :through => :invitees
  has_many :favorites, :as => :favoritable
  has_many :comments, :as => :commentable

  validates :name, :presence => true
  #default_scope order: 'showcases.id ASC'
  before_destroy :check_if_default_showcase_is_being_destroyed

  def check_if_default_showcase_is_being_destroyed
    if (self.default? && self.account.number_of_default_showcases == 1)
      errors.add :account, "You cannot destroy the default showcase of the account"
      errors.blank?
    end
  end

  def has_invitee?(account)
    return false unless account
    self.invitees.each do |invitee|
      return true if invitee.account_id == account.id
    end
    false
  end

  def cover_picture
    Picture.find_by_id(self.cover_picture_id)
  end

  def owner_full_name
    profile = self.account.profile
    first_name = profile.first_name || ""
    last_name = profile.last_name || ""
    first_name + " " + last_name
  end

  def non_owner_accounts
    accs = []
    Account.all.each do |acc|
      accs << acc if (acc != self.account && acc.valid? )
    end
    accs
  end

  def to_s
    "\"#{self.account.username}\""
  end

end
