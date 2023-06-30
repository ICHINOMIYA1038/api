class ChangeDataTitleToPost < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :title, :string, limit: 30
  end
end
