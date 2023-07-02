class AddChatchphraseToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :catchphrase, :string, limit: 80
  end
end
