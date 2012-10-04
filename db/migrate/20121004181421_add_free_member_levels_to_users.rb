class AddFreeMemberLevelsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :free_member_level, :string
  end
end
