class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_level, :integer, :limit => 1
  end
end
