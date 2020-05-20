class AddUserIdToCommissions < ActiveRecord::Migration[6.0]
  def change
    add_column :commissions, :user_id, :integer
    add_index  :commissions, :user_id
  end
end
