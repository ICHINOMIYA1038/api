class FavoritesController < ApplicationController
  before_action :set_post
  #before_action :authenticate_api_vi_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  
=begin
  def create
    if @post.user_id != current_api_v1_user.user_id   # 投稿者本人以外に限定
      @favorite = Favorite.create(user_id: current_api_v1_user.user_id, post_id: @post.id)
    end
  end
=end
 
  # お気に入り登録
  def create
      @favorite = Favorite.create(user_id: current_api_v1_user.user_id, post_id: @post.id)
  end
  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_api_v1_user.user_id, post_id: @post.id)
    @favorite.destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end