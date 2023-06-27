class Post < ApplicationRecord
    include Rails.application.routes.url_helpers
    has_one_attached :mainfile
    def file_url
        # 紐づいている画像のURLを取得する
        mainfile.attached? ? url_for(mainfile) : nil
    end

end
