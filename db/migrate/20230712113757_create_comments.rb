class CreateComments < ActiveRecord::Migration[7.0]
    def change
      create_table :comments do |t|
        t.text :body
        t.bigint  :parent_comment_id
        t.integer :post_id, null: false
  
        t.timestamps
      end
      add_foreign_key :comments, :comments, column: :parent_comment_id
      add_foreign_key :comments, :posts, column: :post_id , primary_key: "post_id"
      add_index :comments, :post_id
      add_index :comments, :parent_comment_id
    end
end
