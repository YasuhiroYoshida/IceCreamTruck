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

ActiveRecord::Schema.define(version: 2021_05_10_113407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flavors", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "truck_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_flavors_on_name"
    t.index ["truck_id"], name: "index_flavors_on_truck_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "type"
    t.bigint "flavor_id"
    t.integer "price", default: 0, null: false
    t.integer "sold", default: 0, null: false
    t.integer "remaining", default: 0, null: false
    t.integer "revenue", default: 0, null: false
    t.bigint "truck_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flavor_id"], name: "index_products_on_flavor_id"
    t.index ["id", "type"], name: "index_products_on_id_and_type"
    t.index ["truck_id"], name: "index_products_on_truck_id"
  end

  create_table "trucks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "flavors", "trucks"
  add_foreign_key "products", "flavors"
  add_foreign_key "products", "trucks"
end
