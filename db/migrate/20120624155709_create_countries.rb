class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :limit => 50
      t.string :iso2, :limit => 2
      t.string :iso3, :limit => 3
    end

    add_index :countries, :name
  end
end
