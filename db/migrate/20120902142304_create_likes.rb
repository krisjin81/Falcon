class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :profile_id
      t.integer :likeable_id
      t.string :likeable_type
      t.timestamps
    end

    add_index :likes, [:profile_id, :likeable_type, :likeable_id]
  end
end
