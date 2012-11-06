class Favorite < ActiveRecord::Base
  belongs_to :favoritable, :polymorphic => true
  attr_accessible :account_id
end
