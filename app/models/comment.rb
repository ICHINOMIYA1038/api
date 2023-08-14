class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :parent_comment, class_name: 'Comment', optional: true
    has_many :replies, class_name: 'Comment', foreign_key: :parent_comment_id

    def user_image_url
        user.image_url if user.present?
    end
end
