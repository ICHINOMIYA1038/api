class Access < ApplicationRecord
    belongs_to :post
    belongs_to :user, optional: true
  
    validates :post, presence: true
end
