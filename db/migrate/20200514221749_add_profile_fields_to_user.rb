class AddProfileFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :image_url, :string
  end
end
