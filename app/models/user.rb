class User < ApplicationRecord
    
    include Rails.application.routes.url_helpers
    has_one_attached :avatar
    has_and_belongs_to_many :chat_rooms
    has_many :messages
    has_many :posts, foreign_key: "user_id"
    has_many :accesses, foreign_key: "user_id"
    has_many :favorites, dependent: :destroy     # ユーザー/お気に入り → 1:多
    has_many :comments


    def set_default_avatar #一旦停止。nullのまま。
        unless avatar.attached?
          avatar.attach(io: File.open(Rails.root.join('public', 'uploads', 'default_avatar.png')), filename: 'default_avatar.png', content_type: 'image/png')
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


