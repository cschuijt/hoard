class AddPrivateToCommissions < ActiveRecord::Migration[6.0]
  def change
    add_column :commissions, :private, :boolean, default: false
  end
end
