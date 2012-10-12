class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.string :name, :null => false
      t.string :content
      t.boolean :publicly_visible, :null => false, :default => true
      t.integer :account_id

      t.timestamps
    end
    add_index :showcases, [:account_id, :created_at]
  end
end
