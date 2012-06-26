class CreateBusinessProfilesBusinessStyles < ActiveRecord::Migration
  def up
    create_table :business_profiles_business_styles do |t|
      t.integer :business_profile_id
      t.integer :business_style_id
    end

    remove_column :business_profiles, :style
  end

  def down
    add_column :business_profiles, :style, :integer, :limit => 1
    drop_table :business_profiles_business_styles
  end
end
