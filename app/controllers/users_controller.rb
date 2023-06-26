class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users
    end
    
    def show
      puts :id
      @user = User.find_by(user_id: params[:id])
      puts @user
      render json: @user
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
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
      params.require(:user).permit(:name, :email)
    end
end
