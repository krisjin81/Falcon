class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.integer :account_id
      t.integer :showcase_id

      t.timestamps
    end
    add_index :invitees, [:account_id, :showcase_id]
  end
end
