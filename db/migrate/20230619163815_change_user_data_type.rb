class ChangeUserDataType < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :user_id, :string
  end
end
