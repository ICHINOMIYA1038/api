class AddPrimaryKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_id
    remove_column :users, :id
    add_column :users, :user_id, :primary_key
  end
end
