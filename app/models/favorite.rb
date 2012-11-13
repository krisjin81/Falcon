class Favorite < ActiveRecord::Base
  belongs_to :favoritable, :polymorphic => true
  belongs_to :account
  attr_accessible :account_id
end
# == Schema Information
#
# Table name: favorites
#
#  id               :integer(4)      not null, primary key
#  favoritable_id   :integer(4)
#  favoritable_type :string(255)
#  account_id       :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

