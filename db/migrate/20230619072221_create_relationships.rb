class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.string :followed_id
      t.string :followered_id

      t.timestamps
    end
    add_foreign_key :relationships, :users, column: :user_id , primary_key: :followed_id
    add_foreign_key :relationships, :users, column: :user_id , primary_key: :followered_id
  end
end
