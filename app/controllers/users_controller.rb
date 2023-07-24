class UsersController < ApplicationController
    #before_action :authenticate_api_v1_user!
    include AuthHelper
    include Pagination
    
    def index
        @users = User.with_attached_avatar
        render json: @users ,methods: [:image_url]
    end

    def show
      @user = User.find_by(user_id: params[:id])  
      render json: @user ,methods: [:image_url]
    end

    def current_user
      if current_api_v1_user
        render json:{
          status:"Ok"
          user:current_api_v1_user
        }
      else 
        render json:{
          status:"Ng"
          user:[]
      }
    end
    end

    def favorites
      if current_api_v1_user
        favorites = Favorite.where(user_id: current_api_v1_user.user_id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
        @posts = Post.joins(:user).where(post_id: favorites).select('posts.*, users.name')
        paged = params[:paged]
        per = params[:per].present? ? params[:per] : 10
        
        @posts_paginated = @posts.page(paged).per(per)
        @pagination = pagination(@posts_paginated)
        @result = @posts_paginated.as_json(
        include: {
          tags: {},
          user: {
            only: :name
          }
    },
    methods: [:file_url, :image_url, :user_image_url, :favo_num, :access_num]
  )

    render json: {
      posts: @result,
      pagination: @pagination
    }

      else
        favorites = Favorite.where(user_id: 54).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
        @posts = Post.joins(:user).where(post_id: favorites).select('posts.*, users.name')
        paged = params[:paged] 
        per = params[:per].present? ? params[:per] : 10
        
        @posts_paginated = @posts.page(paged).per(per)
        @pagination = pagination(@posts_paginated)
        @result = @posts_paginated.as_json(
        include: {
          tags: {},
          user: {
            only: :name
          }
    },
    methods: [:file_url, :image_url, :user_image_url, :favo_num, :access_num]
  )

    render json: {
      posts: @result,
      pagination: @pagination
    }
    
      end
    end

    def setting
      if current_api_v1_user
        if current_api_v1_user.update(user_profile_params)
          render json: { message: "成功" }
        else
          render json: { message: "不明なエラー" }
        end
      else
        render json: { message: "ログインしてください" }
      end
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

    def resend_confirmation_email
      user = User.find_by(email: params[:email])
  
      if user && !user.confirmed?
        user.send_confirmation_instructions
        render json: { message: "Confirmation email has been resent." }
      else
        render json: { error: "User not found or already confirmed." }
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email,:avatar,:password,:password_confirmation)
    end

    def user_profile_params
      params.require(:user).permit(:name, :location,:group,:website,:bio)
    end
end

