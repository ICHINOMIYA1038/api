class CreateGroupUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :group_users do |t|
      t.integer :user_id, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :group_users, :users, column: :user_id ,primary_key: "user_id" 
    add_index :group_users, :user_id
  end
end
