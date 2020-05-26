class ChangeCommissionsFoldersToFilings < ActiveRecord::Migration[6.0]
  def change
    rename_table :commissions_folders, :filings
    add_column :filings, :id, :primary_key
  end
end
