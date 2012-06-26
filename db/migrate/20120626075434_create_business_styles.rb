class CreateBusinessStyles < ActiveRecord::Migration
  def change
    create_table :business_styles do |t|
      t.string :name, :limit => 50
      t.timestamps
    end
  end
end
