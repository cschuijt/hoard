class CreateCommissions < ActiveRecord::Migration[6.0]
  def change
    create_table :commissions do |t|
      t.string    :title
      t.text      :description
      t.boolean   :started
      t.boolean   :finished
      t.datetime  :started_at
      t.datetime  :finished_at

      t.timestamps
    end

    add_index :commissions, :title
    add_index :commissions, :started
    add_index :commissions, :finished
    add_index :commissions, :started_at
    add_index :commissions, :finished_at

  end
end
