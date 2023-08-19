class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.datetime :sent_at
      t.bigint :chat_room_id, null: false # `add_column` 行を削除
      t.integer :user_id, null: false # `add_column` 行を削除
      t.timestamps
    end
    add_foreign_key :messages, :users, column: :user_id ,primary_key: "user_id" 
    add_foreign_key :messages, :chat_rooms, column: :chat_room_id ,primary_key: "id" 
    add_index :messages, :chat_room_id
    add_index :messages, :user_id
  end
end
