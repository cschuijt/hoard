class RenamePrivateFolders < ActiveRecord::Migration[6.0]
  def change
    rename_column :folders, :hidden, :private
  end
end
