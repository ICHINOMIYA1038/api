class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :post_id
      t.string :user_id
      t.string :content
      t.string :image_id
      t.datetime :createdAt
      t.datetime :updatedAt
      t.datetime :deletedAt

      t.timestamps

    end
    add_foreign_key :posts, :users, column: :user_id
  end
end
