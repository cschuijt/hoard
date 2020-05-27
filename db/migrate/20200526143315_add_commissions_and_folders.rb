class AddCommissionsAndFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :commissions_folders, id: false do |t|
      t.belongs_to :commission, foreign_key: true
      t.belongs_to :folder,     foreign_key: true
    end
  end
end
