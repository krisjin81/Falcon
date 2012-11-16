class Group < ActiveRecord::Base
  attr_accessible :community_group, :member_limit, :name, :open_subscription, :owner_id
end
