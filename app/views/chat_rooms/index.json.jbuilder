# app/views/chat_rooms/index.json.jbuilder

json.array! @chat_rooms do |chat_room|
    json.id chat_room.id
    json.name chat_room.name
    json.users chat_room.users do |user|
      json.id user.user_id
      json.name user.name
      # 他のユーザーの属性を必要に応じて追加
    end
  end