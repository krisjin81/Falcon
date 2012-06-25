class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table :business_profiles do |t|
      t.integer :affiliate_id
      t.string :business_name, :limit => 50
      t.integer :business_type, :limit => 1
      t.integer :style, :limit => 1
      t.integer :audience, :limit => 1
      t.integer :age_group, :limit => 1
      t.string :contact_first_name, :limit => 50
      t.string :contact_last_name, :limit => 50
      t.string :contact_email
      t.text :about, :limit => 1000
      t.string :website
      t.integer :country_id
      t.timestamps
    end
  end
end
