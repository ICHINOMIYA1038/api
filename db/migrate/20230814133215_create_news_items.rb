class CreateNewsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :news_items do |t|
      t.string :date
      t.string :category
      t.string :title

      t.timestamps
    end
  end
end
