class CreateBlogposts < ActiveRecord::Migration
  def change
    create_table :blogposts do |t|
      t.string   :content, :null => false
      t.integer  :account_id

      t.timestamps
    end
    add_index :blogposts, [:account_id, :created_at]
  end
end
