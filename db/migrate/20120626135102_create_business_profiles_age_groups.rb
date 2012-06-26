class CreateBusinessProfilesAgeGroups < ActiveRecord::Migration
  def up
    create_table :business_profiles_age_groups do |t|
      t.integer :business_profile_id
      t.integer :age_group_id
    end

    remove_column :business_profiles, :age_group
  end

  def down
    add_column :business_profiles, :age_group, :integer, :limit => 1
    drop_table :business_profiles_age_groups
  end
end
