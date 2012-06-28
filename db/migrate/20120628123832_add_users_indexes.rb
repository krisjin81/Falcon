class AddUsersIndexes < ActiveRecord::Migration
  def change
    add_index :users, :created_at
    add_index :users, :confirmed_at
    add_index :users, :last_sign_in_at
  end
end
