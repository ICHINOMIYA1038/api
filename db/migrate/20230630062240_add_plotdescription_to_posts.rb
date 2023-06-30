class AddPlotdescriptionToPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.string :synopsis, limit: 100
      t.string :catchphrase, limit: 30
      t.integer :number_of_men
      t.integer :number_of_women
      t.integer :total_number_of_people
      t.integer :playtime
    end
end
end