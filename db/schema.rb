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

ActiveRecord::Schema.define(version: 2021_10_26_211834) do

  create_table "airports", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "timezone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "flight_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.datetime "departing_time"
    t.datetime "arriving_time"
    t.integer "capacity", default: 300
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "from_airport_id"
    t.integer "to_airport_id"
    t.index ["from_airport_id"], name: "index_flights_on_from_airport_id"
    t.index ["to_airport_id"], name: "index_flights_on_to_airport_id"
  end

  create_table "params_searches", force: :cascade do |t|
    t.date "departing_date"
    t.integer "passengers", default: 1
    t.integer "from_airport_id"
    t.integer "to_airport_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_airport_id"], name: "index_params_searches_on_from_airport_id"
    t.index ["to_airport_id"], name: "index_params_searches_on_to_airport_id"
  end

  add_foreign_key "bookings", "flights"
  add_foreign_key "flights", "airports", column: "from_airport_id"
  add_foreign_key "flights", "airports", column: "to_airport_id"
  add_foreign_key "params_searches", "airports", column: "from_airport_id"
  add_foreign_key "params_searches", "airports", column: "to_airport_id"
end
