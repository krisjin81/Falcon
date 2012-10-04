class AddAffiliateMemberLevelsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :affiliate_member_level, :string
  end
end
