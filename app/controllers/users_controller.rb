class UsersController < ApplicationController
    #before_action :authenticate_api_v1_user!
    include AuthHelper
    def index
        @users = User.with_attached_avatar
        puts "ログメッセージ"
        render json: @users ,methods: [:image_url]
    end

=begin
    def show
      @user = User.find_by(user_id: params[:id])
      if @user.admin==true
        render json: @user ,methods: [:image_url]
      elsif logged_in?(@user)
        render json: @user ,methods: [:image_url]
      else 
        render json: { error: "ログインしていません" }, status: :unauthorized
      end
    end
=end

    def show
      @user = User.find_by(user_id: params[:id])  
      render json: @user ,methods: [:image_url]
    end

    def favorites
      favorites = Favorite.where(user_id: current_api_v1_user.user_id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
      @favorite_list = Post.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
      render json: @favorite_list 
    end

    def new
      @user = User.new
    end

    def edit
      before_action :authenticate_api_v1_user!
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.avatar.purge
      if @user.update(user_params)
        @user.avatar.attach(user_params[:avatar]) if params[:avatar].present?
        # 更新に成功した場合を扱う
      else
        render 'edit', status: :unprocessable_entity
      end
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
        puts "ok"
      else
        render :new
        puts "error"
      end
    end
  

    def destroy
      post = Post.find_by(user_id: params[:id])
      user = User.find_by(user_id: params[:id])
    
      post.destroy if post
      user.destroy if user
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email,:avatar,:password,:password_confirmation)
    end
end

