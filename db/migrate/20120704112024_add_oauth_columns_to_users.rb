class AddOauthColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :external_user_id, :integer, :limit => 8
    add_column :users, :provider, :string, :limit => 20
    add_index :users, [:provider, :external_user_id]
  end
end
