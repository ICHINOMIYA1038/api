class ChatRoomsController < ApplicationController
    include AuthHelper
    before_action :set_chat_room, only: [:show]
  
    def index
      @chat_rooms = ChatRoom.all
      render json: @chat_rooms
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


  
    private
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end
    
  end  