class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  
  include Pagination

  # GET /api/v1/users/:user_id/posts
  def user_posts
    user = User.find(params[:user_id])
    @posts = user.posts
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

  def favo
    if current_api_v1_user
      post = Post.find_by(post_id: params[:id])
      favorite = Favorite.find_by(user_id: current_api_v1_user.user_id, post_id: post.post_id)
  
      if favorite.nil?
        render json: { result: "NG" }
      else
        render json: { result: "OK" } 
      end
    else
      render json: { result: "NG" } #未ログイン
    end
  end

  def sample
    @posts = Post.order(created_at: :desc)
    #ページネーション指定ページ
    paged = params[:paged]
    #指定がない場合はデフォルトを10ページずつ（kaminari標準のlimit_valueは25）
    per = params[:per].present? ? params[:per] : 10
    #ページネーションが適用された投稿
    @posts_paginated = @posts.page(paged).per(per)
    #ページネーション情報（concernに記載）
    @pagination = pagination(@posts_paginated)

    render json: {
      posts: @posts_paginated,
      pagination: @pagination
  }
    
  end


  # GET /posts
  def index
    @posts = Post.includes(:user).select('posts.*, users.name')
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

  # GET /posts/1
  def show

    access_params = {
      access_date: Date.current,
      post_id: @post.id,
      ip_address: request.remote_ip
    }

    @access = Access.find_or_initialize_by(access_params)
    @access.save unless @access.persisted?
    render json: @post , methods: [:file_url, :image_url, :user_image_url,:favo_num,:access_num]
  end

  def new
    @post = Post.new
  end

  # POST /posts
  def create
    if current_api_v1_user
      user = User.find_by(user_id: current_api_v1_user.user_id)  
      @post =user.posts.new(post_params)

      if params[:tags]
        tag_names = params[:tags].split(',') # タグをカンマ区切りの文字列から配列に変換
        
        tag_names.each do |tag_name|
          tag = Tag.find_by(name: tag_name)
          unless tag
            tag = Tag.new(name: tag_name)
            tag.save
          end
          @post.tags << tag
        end
      end
  
      if @post.save
        @post.mainfile.attach(user_params[:mainfile]) if params[:mainfile].present?
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "ログインしていません。" }, status: :unauthorized
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      @post.mainfile.attach(user_params[:mainfile]) if params[:mainfile].present?
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  #/posts/[id]/favo_num
  def favo_num
    @post = Post.find(params[:id])
    render json: @post , methods: [:favo_num]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(
        :title,
        :catchphrase,
        :number_of_men,
        :number_of_women,
        :total_number_of_people,
        :playtime,
        :user_id,
        :mainfile,
        :postImage,
        )
    end
end
