class Invitee < ActiveRecord::Base
  attr_accessible :account_id, :showcase_id
  belongs_to :account
  belongs_to :showcase
end
# == Schema Information
#
# Table name: invitees
#
#  id          :integer(4)      not null, primary key
#  account_id  :integer(4)
#  showcase_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

