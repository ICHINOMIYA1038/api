class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates_uniqueness_of :post_id, scope: :user_id    # バリデーション（ユーザーと記事の組み合わせは一意）
    
end
