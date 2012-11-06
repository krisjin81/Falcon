class Invitee < ActiveRecord::Base
  attr_accessible :account_id, :showcase_id
  belongs_to :account
  belongs_to :showcase
end
