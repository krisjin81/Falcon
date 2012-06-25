class CreateLanguageSettings < ActiveRecord::Migration
  def change
    create_table :language_settings do |t|
      t.integer :user_id
      t.string :locale, :limit => 3
    end
  end
end
