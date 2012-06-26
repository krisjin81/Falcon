class CreateBusinessProfilesAudience < ActiveRecord::Migration
  def up
    create_table :business_profiles_audiences do |t|
      t.integer :business_profile_id
      t.integer :audience_id
    end

    remove_column :business_profiles, :audience
  end

  def down
    add_column :business_profiles, :audience, :integer, :limit => 1
    drop_table :business_profiles_audiences
  end
end
