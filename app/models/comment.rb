class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    def user_image_url
        user.image_url if user.present?
    end
end
