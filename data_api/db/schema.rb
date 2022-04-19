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

ActiveRecord::Schema.define(version: 2022_04_17_115743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "date_start", null: false
    t.datetime "date_end", null: false
    t.index ["name"], name: "index_events_on_name"
  end

  create_table "reserves", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.datetime "time_start", null: false
    t.datetime "time_end", null: false
    t.index ["ticket_id"], name: "index_reserves_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "ticket_type", null: false
    t.integer "status", null: false
    t.integer "start_price", null: false
    t.bigint "event_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "reserves", "tickets"
  add_foreign_key "tickets", "events"
end
