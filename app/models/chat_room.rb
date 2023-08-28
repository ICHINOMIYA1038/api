class ChatRoom < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :messages

    private

  def increment_users_count(user)
    self.class.increment_counter(:users_count, id)
  end

  def decrement_users_count(user)
    self.class.decrement_counter(:users_count, id)
  end
end
