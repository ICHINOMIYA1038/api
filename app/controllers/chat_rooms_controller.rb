class ChatRoomsController < ApplicationController
    include AuthHelper
    before_action :set_chat_room, only: [:show]
  
    def index
      if current_api_v1_user.nil?
        render json: { error: 'Not authenticated' }, status: :unauthorized
        return
      end
      
      
      chatrooms = current_api_v1_user.chat_rooms.includes(:users)
      
      render json: chatrooms, include: 
      {
         users: {
           only: [:user_id, :name],
           methods: [:image_url]
           } 
      }
    end

    def create
      if current_api_v1_user.nil?
        render json: { error: 'Not authenticated' }, status: :unauthorized
        return
      end

      user_ids = params[:user_ids] | []

      # current_api_v1_userのuser_idも含めてユーザーIDを追加
      all_user_ids = user_ids.map(&:to_i) << current_api_v1_user.user_id
      
      # ユーザーIDをソートして、重複を除いた一意のキーを作成
      unique_sorted_user_ids = all_user_ids.uniq.sort

      chatrooms = current_api_v1_user.chat_rooms
      chat_room = chatrooms
      .joins(:users)
      .where(users_count:unique_sorted_user_ids.length)
      .where(users: { user_id: unique_sorted_user_ids })
      .group("chat_rooms.id")
      .having("COUNT(users.user_id) = ?", unique_sorted_user_ids.length)
      .first
    
      # 一致するチャットルームが見つからない場合は新しいチャットルームを作成
      if chat_room.nil?
        chat_room = ChatRoom.create(users_count:unique_sorted_user_ids.length)
        chat_room.users << User.find(unique_sorted_user_ids)
        created = true
      else
        created = false
      end
      
      render json: { chat_room: chat_room, created: created }
    end
  
    def show
      if current_api_v1_user.nil?
        render json: { error: 'Not authenticated' }, status: :unauthorized
        return
      end
    
      @users = @chat_room.users
    
      if @users.exclude?(current_api_v1_user)
        render json: { error: 'Not authorized' }, status: :unauthorized
        return
      end
    
      @messages = @chat_room.messages
      render json: { chat_room: @chat_room, messages: @messages, users: @users , active_user:current_api_v1_user }
    end


    def associate_user_with_chat_room
      user = User.find(params[:user_id])
      chat_room = ChatRoom.find(params[:chat_room_id])
      
      ChatRoomsUsers.create(user: user, chat_room: chat_room)
      
      render json: { message: 'User associated with chat room successfully' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User or chat room not found' }, status: :not_found
    end

    

    def find_or_create_chat_room
      # リクエストから渡されたユーザーのIDを取得
      user_ids = params[:user_ids] 
      
      # 渡されたユーザーIDの組み合わせをソートして、一意のキーを作成
      sorted_user_ids = user_ids.map(&:to_i).sort
      unique_sorted_user_ids = sorted_user_ids.uniq
      
      # 一意のキーに基づいて既存のチャットルームを検索
      chat_room = ChatRoom.joins(:users)
                          .where(users_count:unique_sorted_user_ids.length)
                          .where(users: { user_id: unique_sorted_user_ids })
                          .group("chat_rooms.id")
                          .having("COUNT(users.user_id) = ?", unique_sorted_user_ids.length)
                          .first
      
      # 一致するチャットルームが見つからない場合は新しいチャットルームを作成
      if chat_room.nil?
        chat_room = ChatRoom.create(users_count:unique_sorted_user_ids.length)
        chat_room.users << User.find(user_ids)
        created = true
      else
        created = false
      end
      
      render json: { chat_room: chat_room, created: created }
    end

  
    private
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end
    
  end  