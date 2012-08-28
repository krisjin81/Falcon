class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.string :body, :limit => 1000
      t.integer :author_id
      t.timestamps
    end
  end
end
