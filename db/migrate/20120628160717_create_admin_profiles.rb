class CreateAdminProfiles < ActiveRecord::Migration
  def change
    create_table :admin_profiles do |t|
      t.integer :admin_id
      t.string :username, :limit => 50
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.timestamps
    end

    add_index :admin_profiles, :username
    add_index :admin_profiles, :first_name
    add_index :admin_profiles, :last_name
  end
end
