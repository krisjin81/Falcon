class MigrateToCarierwawe < ActiveRecord::Migration
  def up
    remove_column :avatars, :image_file_name
    remove_column :avatars, :image_file_size
    remove_column :avatars, :image_content_type
    remove_column :avatars, :image_updated_at
    add_column :avatars, :image, :string

    remove_column :pictures, :image_file_name
    remove_column :pictures, :image_file_size
    remove_column :pictures, :image_content_type
    remove_column :pictures, :image_updated_at
    add_column :pictures, :image, :string
  end

  def down
    remove_column :avatars, :image
    add_column :avatars, :image_file_name, :string
    add_column :avatars, :image_file_size, :integer
    add_column :avatars, :image_content_type, :string
    add_column :avatars, :image_updated_at, :datetime

    remove_column :pictures, :image
    add_column :pictures, :image_file_name, :string
    add_column :pictures, :image_file_size, :integer
    add_column :pictures, :image_content_type, :string
    add_column :pictures, :image_updated_at, :datetime
  end
end
