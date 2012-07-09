class RenameBusinessStylesToStyles < ActiveRecord::Migration
  def up
    rename_table :business_styles, :styles
    rename_table :business_profiles_business_styles, :business_profiles_styles
    rename_column :business_profiles_styles, :business_style_id, :style_id
  end

  def down
  end
end
