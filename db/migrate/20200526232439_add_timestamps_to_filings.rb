class AddTimestampsToFilings < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :filings, null: true
  end
end
