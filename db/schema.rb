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

ActiveRecord::Schema[7.1].define(version: 2024_10_31_013249) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.string "kind"
    t.string "shift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "university_offer_id", null: false
    t.decimal "discount_percentage"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_offer_id"], name: "index_offers_on_university_offer_id"
  end

  create_table "university_offers", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.decimal "full_price"
    t.integer "max_payments"
    t.string "enrollment_semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_university_offers_on_course_id"
  end

  add_foreign_key "offers", "university_offers"
  add_foreign_key "university_offers", "courses"
end
