class AddUserIdTousers < ActiveRecord::Migration[7.0]
  def up  
    remove_column :users, :id
    # user_idカラムを追加し、PKとして設定

    #postgres用
    #add_column :users, :user_id, :serial, null: false, primary_key: true,AUTO_INCREMENT:true
    #mysql
    add_column :users, :user_id, :integer, null: false, primary_key: true,AUTO_INCREMENT:true
    add_foreign_key :posts, :users, column: :user_id, primary_key: :user_id
  end

  def down
    # user_idカラムを削除
    remove_column :users, :user_id

    # idカラムを追加
    add_column :users, :id, :primary_key
  end
end