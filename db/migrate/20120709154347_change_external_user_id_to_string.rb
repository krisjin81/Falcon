class ChangeExternalUserIdToString < ActiveRecord::Migration
  def up
    change_column :users, :external_user_id, :string, :limit => 50
  end

  def down
    change_column :users, :external_user_id, :integer, :limit => 8
  end
end
