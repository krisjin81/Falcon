class AddStylesToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :style, :string
  end
end
