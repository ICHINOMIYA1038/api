class CreateAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :accesses do |t|
      t.datetime :access_date
      t.integer :post_id, null: false
      t.integer :user_id
      t.string :ip_address

      t.timestamps
    end
    add_foreign_key :accesses, :users, column: :user_id ,primary_key: "user_id" 
    add_foreign_key :accesses, :posts, column: :post_id ,primary_key: "post_id" 
    add_index :accesses, :post_id
    add_index :accesses, :user_id
  end
end
