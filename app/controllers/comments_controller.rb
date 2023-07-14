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

      def parent

        @post = Post.find(params[:post_id])
        @comments = @post.comments.where(parent_comment_id: nil)
        @allcomments = @post.comments.joins(:user).all

        all_comments = @comments.map do |comment|
          user = comment.user
          {
            comment_id: comment.id,
            body: comment.body,
            user_id: comment.user_id,
            name: user.name,
            post_id:comment.post_id,
            user_image_url: user.image_url,
            child_comments: @allcomments.select { |child| child.parent_comment_id == comment.id }
          }
        end
        render json: all_comments ,methods: [:user_image_url] , include: :user
      end

      def show_child
        @post = Post.find(params[:post_id])
        @comments = @post.comments.where(parent_comment_id: nil)
        @childcomments = @post.comments.where(parent_comment_id: params[:comment_id])
        
        render json: @childcomments
      end


      private
      def comment_params
        params.require(:comment).permit(:body, :post_id, :parent_comment_id)
      end
end
