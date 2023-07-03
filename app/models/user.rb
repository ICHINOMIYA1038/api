class User < ApplicationRecord
    
    include Rails.application.routes.url_helpers
    has_one_attached :avatar
    has_many :posts, foreign_key: "user_id"
    after_create :set_default_avatar
    has_many :favorites, dependent: :destroy     # ユーザー/お気に入り → 1:多

    def set_default_avatar
        unless avatar.attached?
          avatar.attach(io: File.open(Rails.root.join('public', 'uploads', 'default_avatar.png')), filename: 'default_avatar.png', content_type: 'image/png')
        end
    end

    def image_url
        # 紐づいている画像のURLを取得する
        avatar.attached? ? url_for(avatar) : nil
    end

    devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
    include DeviseTokenAuth::Concerns::User


end



class Post < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
end

