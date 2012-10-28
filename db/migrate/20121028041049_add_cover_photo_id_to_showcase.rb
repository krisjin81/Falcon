class AddCoverPhotoIdToShowcase < ActiveRecord::Migration
  def change
    add_column :showcases, :cover_picture_id , :integer
  end
end
