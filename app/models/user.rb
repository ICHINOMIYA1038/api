class User < ApplicationRecord
    has_many :posts, foreign_key: "user_id"
end

class Post < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
end