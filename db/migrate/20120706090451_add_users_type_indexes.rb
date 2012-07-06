class AddUsersTypeIndexes < ActiveRecord::Migration
  def change
    add_index :users, [:type, :email]
    add_index :users, [:type, :provider, :id]
    add_index :users, [:type, :provider, :email]
    add_index :users, [:type, :created_at]
    add_index :users, [:type, :confirmed_at]
    add_index :users, [:type, :last_sign_in_at]
  end
end
