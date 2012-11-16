class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, :null => false, :unique => true
      t.boolean :open_subscription, :default => false, :null => false
      t.boolean :community_group, :default => true , :null => false
      t.integer :member_limit, :default => 50, :null => false
      t.integer :owner_id, :null => false

      t.timestamps
    end

  end
end
