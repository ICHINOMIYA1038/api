class AddTitleToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :title, :boolean ,null:false,default:"title"
  end
end
