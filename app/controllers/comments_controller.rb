class CommentsController < ApplicationController
      def create
        # コメントの作成処理
        if current_api_v1_user
            user = User.find_by(user_id: current_api_v1_user.user_id)  
            @comment =user.comments.new(comment_params)
            @comment.post_id = params[:post_id]
            @comment.parent_comment_id = params[:parent_comment_id]

            if @comment.save
                render json: { success: "コメントが作成されました。" }, status: :ok
            else
                render json: { error: "コメントの作成に失敗しました。" }, status: :unprocessable_entity
            end
        else
            render json: { error: "ログインしていません。" }, status: :unauthorized
        end
      end
    
      def destroy
        @comment = Comment.find(params[:id])
      
        if @comment.update(deleted: true)
          # コメントの削除に成功した場合の処理
          render json: { success: "コメントが削除されました。" }, status: :ok
        else
          # コメントの削除に失敗した場合の処理
          render json: { error: "コメントの削除に失敗しました。" }, status: :unprocessable_entity
        end
      end

      def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments
    
        render json: @comments
      end

      private
      def comment_params
        params.require(:comment).permit(:body, :post_id, :parent_comment_id)
      end
end
