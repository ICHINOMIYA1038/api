class Post < ApplicationRecord
    include Rails.application.routes.url_helpers
    has_one_attached :mainfile
    has_one_attached :postImage
    def file_url
        # 紐づいている画像のURLを取得する
        mainfile.attached? ? url_for(mainfile) : nil
    end

    def image_url
        # 紐づいている画像のURLを取得する
        postImage.attached? ? url_for(postImage) : nil
    end

end
