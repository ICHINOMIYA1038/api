class User < ApplicationRecord
    
    include Rails.application.routes.url_helpers
    has_one_attached :avatar
    validate :avatar_type

    

    has_many :posts, foreign_key: "user_id"
    has_many :accesses, foreign_key: "user_id"
    after_create :set_default_avatar
    has_many :favorites, dependent: :destroy     # ユーザー/お気に入り → 1:多
    has_many :comments


    def set_default_avatar
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



    private

  def avatar_type
      if !avatar.blob.content_type.in?(%('image/jpeg image/png'))
        avatar.purge
        errors.add(:avatars, 'はjpegまたはpng形式でアップロードしてください')
    end
  end

end


