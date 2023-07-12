class AddDeletedToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :deleted, :boolean, default: false
  end
end
