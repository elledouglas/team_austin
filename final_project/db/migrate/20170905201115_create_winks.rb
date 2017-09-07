class CreateWinks < ActiveRecord::Migration[5.1]
  def change
    create_table :winks do |t|
      t.integer :wink_sender_id
      t.integer :wink_recipient_id

      t.timestamps
    end
    add_index :winks, :wink_sender_id
    add_index :winks, :wink_recipient_id
    add_index :winks, [:wink_sender_id, :wink_recipient_id]
  end
end
