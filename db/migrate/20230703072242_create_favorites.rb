class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: { to_table: :users, column: :user_id }
      t.references :post, null: false, foreign_key: { to_table: :posts, column: :post_id }

      t.timestamps
    end
  end
end
