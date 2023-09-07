class MessagesController < ApplicationController
    def create
        # コメントの作成処理
        if current_api_v1_user
            user = User.find_by(user_id: current_api_v1_user.user_id)  
            @message =user.messages.new(content:params[:content],chat_room_id:params[:chat_room_id])

            if @message.save
                render json: { success: "コメントが作成されました。" }, status: :ok
            else
                render json: { error: "コメントの作成に失敗しました。" }, status: :unprocessable_entity
            end
        else
            render json: { error: "ログインしていません。" }, status: :unauthorized
        end
    end
end
