class ChangeColumnTypeToPostsPlaytime < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :playtime, :integer
  end
end
