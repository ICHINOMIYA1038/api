class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end

    add_foreign_key :favorites, :users, column: :user_id, primary_key: :user_id
    add_foreign_key :favorites, :posts, column: :post_id, primary_key: :post_id
    add_index :favorites, :user_id  #追加
    add_index :favorites, :post_id
  end
end
