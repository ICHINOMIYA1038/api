class Post < ApplicationRecord
    include Rails.application.routes.url_helpers
    validates :catchphrase, presence: true, length: { maximum: 80 }
    validates :title, presence: true, length: { maximum: 30 }
    has_one_attached :mainfile
    has_one_attached :postImage
    after_create :set_default_Image
    belongs_to :user, foreign_key: "user_id"
    has_many :favorites, dependent: :destroy 
    has_many :accesses
    has_and_belongs_to_many :tags
    has_many :comments

    paginates_per 10  # 1ページあたりの表示件数を指定します


    def set_default_Image
        unless postImage.attached?
            postImage.attach(io: File.open(Rails.root.join('public', 'uploads', 'NoImage.jpg' )), filename: 'NoImage.jpg', content_type: 'image/jpg')
        end
    end

    def file_url
        # 紐づいている画像のURLを取得する
        mainfile.attached? ? url_for(mainfile) : nil
    end

    def image_url
        # 紐づいている画像のURLを取得する
        postImage.attached? ? url_for(postImage) : nil
    end

    def user_image_url
        user.image_url if user.present?
    end

    def favo_num
        favorites.count
    end

    def access_num
        accesses.count
    end

end
