class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
      t.string :attachable_type
      t.integer :attachable_id
      t.string :title
      t.text :dressing_tips
      t.string :brands
      t.string :cost
      t.string :where_to_buy
      t.integer :gender, :limit => 1
      t.timestamps
    end
  end
end
