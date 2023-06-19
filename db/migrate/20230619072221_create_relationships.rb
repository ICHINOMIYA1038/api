class CreateRelationships < ActiveRecord::Migration[7.0]
  def down
    create_table :relationships do |t|
      t.string :followed_id
      t.string :followered_id

      t.timestamps
    end
    add_foreign_key :relationships, :users, column: :followed_id , primary_key: :user_id
    add_foreign_key :relationships, :users, column: :followered_id , primary_key: :user_id
  end
end
