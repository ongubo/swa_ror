# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_22_172103) do
  create_table "elections", force: :cascade do |t|
    t.string "name"
    t.string "election_day"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_election_name", unique: true
  end

  create_table "representatives", force: :cascade do |t|
    t.string "name"
    t.integer "election_id"
    t.string "party"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_representatives_on_election_id"
    t.index ["name"], name: "unique_representative_name", unique: true
  end

  add_foreign_key "representatives", "elections"
end
