class AddDefaultFlagToShowcase < ActiveRecord::Migration
  def change
    add_column :showcases, :default , :boolean, :default=>false
  end
end
