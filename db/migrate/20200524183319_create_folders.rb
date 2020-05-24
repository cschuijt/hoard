class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string     :title
      t.text       :description
      t.boolean    :hidden,      default:     false
      t.belongs_to :user,        foreign_key: true

      t.timestamps
    end
  end
end
