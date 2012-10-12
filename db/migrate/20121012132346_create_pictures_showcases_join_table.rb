class CreatePicturesShowcasesJoinTable < ActiveRecord::Migration
  def change
    create_table :pictures_showcases, :id => false do |t|
      t.integer :picture_id
      t.integer :showcase_id
    end
  end
end
