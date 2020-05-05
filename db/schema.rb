# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_05_183716) do

  create_table "commissions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "started"
    t.boolean "finished"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["finished"], name: "index_commissions_on_finished"
    t.index ["finished_at"], name: "index_commissions_on_finished_at"
    t.index ["started"], name: "index_commissions_on_started"
    t.index ["started_at"], name: "index_commissions_on_started_at"
    t.index ["title"], name: "index_commissions_on_title"
  end

end
