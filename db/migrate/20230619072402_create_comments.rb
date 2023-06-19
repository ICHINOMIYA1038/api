class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment_id
      t.string :user_id
      t.integer :post_id
      t.string :comment
      t.datetime :createdAt
      t.datetime :updatedAt
      t.datetime :deletedAt

      t.timestamps
    end
    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :posts, column: :post_id
  end
end
