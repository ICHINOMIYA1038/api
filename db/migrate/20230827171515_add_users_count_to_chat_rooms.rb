class AddUsersCountToChatRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_rooms, :users_count, :integer, default: 0
  end
end
