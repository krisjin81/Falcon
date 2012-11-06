class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :favoritable, :polymorphic => true
      t.integer :account_id
      t.timestamps
    end
    add_index :favorites, :account_id
  end
end
