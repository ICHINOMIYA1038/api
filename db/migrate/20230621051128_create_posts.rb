class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id:false do |t|
      t.integer :post_id,null:false,primary_key:true
      t.string :content
      t.string :image_id
      t.datetime :createdAt
      t.datetime :updatedAt
      t.datetime :deletedAt

      t.timestamps
    end
  end
end
