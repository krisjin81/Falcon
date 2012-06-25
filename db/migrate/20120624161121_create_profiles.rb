class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :account_id
      t.string :username, :limit => 50
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.date :birth_date
      t.integer :country_id
      t.integer :gender, :limit => 1
      t.timestamps
    end

    add_index :profiles, :account_id
    add_index :profiles, :username, :unique => true
  end
end
