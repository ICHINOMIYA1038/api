class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]


  # GET /api/v1/users/:user_id/posts
  def user_posts
    user = User.find(params[:user_id])
    @posts = user.posts
    render json: @posts ,methods: [:file_url, :image_url]
  end


  # GET /posts
  def index
    @posts = Post.joins(:user).select('posts.*, users.name')
    render json: @posts ,methods: [:file_url, :image_url,:user_image_url]
  end

  # GET /posts/1
  def show
    render json: @post ,methods: [:file_url, :image_url]
  end

  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      @post.mainfile.attach(user_params[:mainfile]) if params[:mainfile].present?
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
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
        :postImage
        


        
        )
    end
end
