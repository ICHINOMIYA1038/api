class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false  do |t|
      t.integer :user_id, null:false, primary_key: true
      t.string :name
      t.string :email
      t.string :password_hash
      t.datetime :createdAt
      t.datetime :updatedAt
      t.datetime :deletedAt

      t.timestamps
    end
  end
end
