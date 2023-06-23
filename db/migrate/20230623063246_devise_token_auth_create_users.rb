class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def change
    
      #add_column :users, :provider, :string, null:false,default:"email"
      add_column :users, :uid,:string,null:false,default:""
      add_column :users, :encrypted_password, :string, null:false,default:""
      add_column :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime
      add_column :users, :allow_password_change, :boolean, default:false
      add_column :users, :remember_created_at, :datetime
      add_column :users, :confirmation_token, :string
      add_column :users, :confirmed_at, :datetime
      add_column :users, :confirmation_sent_at,:datetime
      add_column :users, :unconfirmed_email, :string

      change_column_default :users, :encrypted_password, from: '', to: nil
      change_column_null :users, :encrypted_password, true
      
      add_index :users, :email, unique: true
      add_index :users, [:uid, :provider], unique: true
      add_index :users, :reset_password_token, unique: true
      add_index :users, :confirmation_token, unique: true

      
  end
end
