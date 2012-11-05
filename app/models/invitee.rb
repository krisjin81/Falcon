class Invitee < ActiveRecord::Base
  attr_accessible :account_id, :picture_id
  belongs_to :picture
  belongs_to :account
end
