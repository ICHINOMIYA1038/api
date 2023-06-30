class UsersController < ApplicationController
  

    def index
        @users = User.all
        render json: @users ,methods: [:image_url]
    end

    def show
      @user = User.find_by(user_id: params[:id])
      render json: @user ,methods: [:image_url]
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
      Post.find_by(user_id: params[:id]).destroy
      User.find_by(user_id: params[:id]).destroy
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email,:avatar,:password,:password_confirmation)
    end
end

