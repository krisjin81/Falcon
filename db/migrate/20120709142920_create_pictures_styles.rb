class CreatePicturesStyles < ActiveRecord::Migration
  def change
    create_table :pictures_styles do |t|
      t.integer :picture_id
      t.integer :style_id
    end
  end
end
