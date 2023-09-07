class CreateChatRoomsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms_users do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.bigint :chat_room_id, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :chat_rooms_users, :chat_rooms, column: :chat_room_id ,primary_key: "id" 
    add_foreign_key :chat_rooms_users, :users, column: :user_id ,primary_key: "user_id" 
    add_index :chat_rooms_users, :user_id
    add_index :chat_rooms_users, :chat_room_id
  end
end
