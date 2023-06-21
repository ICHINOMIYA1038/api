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
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
