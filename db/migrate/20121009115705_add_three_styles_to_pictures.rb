class AddThreeStylesToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :s1, :boolean
    add_column :pictures, :s2, :boolean
    add_column :pictures, :s3, :boolean
  end
end
