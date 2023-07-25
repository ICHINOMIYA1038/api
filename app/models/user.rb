class User < ApplicationRecord
    
    include Rails.application.routes.url_helpers
    has_one_attached :avatar

    has_many :posts, foreign_key: "user_id"
    has_many :accesses, foreign_key: "user_id"
    after_create :set_default_avatar
    has_many :favorites, dependent: :destroy     # ユーザー/お気に入り → 1:多
    has_many :comments


    def set_default_avatar
        unless avatar.attached?
          avatar.attach(io: File.open(Rails.root.join('public', 'uploads', 'NoImage.jpg' )), filename: 'NoImage.jpg', content_type: 'image/jpg')
        end
    end

    def image_url
        # 紐づいている画像のURLを取得する
        avatar.attached? ? url_for(avatar) : nil
    end

    def favorite_post?(post)
        posts.exists?(post.post_id)
    end



    devise :database_authenticatable, 
    :registerable,
    :recoverable,
    :rememberable, 
    :validatable,
    :confirmable
    include DeviseTokenAuth::Concerns::User

end


