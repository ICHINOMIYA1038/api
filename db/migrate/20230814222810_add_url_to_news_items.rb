class AddUrlToNewsItems < ActiveRecord::Migration[7.0]
  def change
    add_column :news_items, :url, :string
  end
end
