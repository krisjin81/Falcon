class ChangeAdminLevelFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :users, :admin_level, :string
  end

end
