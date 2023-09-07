class FavoritesController < ApplicationController
  before_action :set_post
  
  # お気に入り登録
  def create
    if current_api_v1_user
      @favorite = Favorite.create(user_id: current_api_v1_user.user_id, post_id: @post.post_id)
      render json: { message: "お気に入りが登録されました。" }
    else
      render json: { error: "ログインしていません。" }, status: :unauthorized
    end
  end
  
  def destroy
    if current_api_v1_user
      @favorite = Favorite.find_by(user_id: current_api_v1_user.user_id, post_id: @post.post_id)
      @favorite.destroy
      render json: { message: "お気に入りが削除されました。" }
    else
      render json: { error: "ログインしていません。" }, status: :unauthorized
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end