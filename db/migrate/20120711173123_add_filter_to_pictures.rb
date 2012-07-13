class AddFilterToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :filter, :string, :limit => 20
    rename_column :pictures, :image, :original_image
    add_column :pictures, :formatted_image, :string
  end
end
