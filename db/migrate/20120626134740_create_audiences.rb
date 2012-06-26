class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.string :name, :limit => 50
      t.timestamps
    end
  end
end
