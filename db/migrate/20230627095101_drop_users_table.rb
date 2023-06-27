class DropUsersTable < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key  :posts, :users, column: :user_id, primary_key: :user_id
    drop_table :users
  end

  def down
    add_remove_foreign_key  :posts, :users, column: :user_id, primary_key: :user_id
    raise ActiveRecord::IrreversibleMigration
  end
end
