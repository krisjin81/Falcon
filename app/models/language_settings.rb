# == Schema Information
#
# Table name: language_settings
#
#  id      :integer(4)      not null, primary key
#  user_id :integer(4)
#  locale  :string(3)
#

class LanguageSettings < ActiveRecord::Base
  belongs_to :user

  has_enumeration_for :locale, :create_helpers => true

  validates :user_id, :presence => true
  validates :locale, :presence => true, :length => { :maximum => 3 }

  attr_protected :user, :user_id
end
