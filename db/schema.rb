# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180129185421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "configurations", force: :cascade do |t|
    t.string "notification_setting", default: "first_notification_to_recipient"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracking_statuses", force: :cascade do |t|
    t.string "date"
    t.string "description"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tracking_id"
  end

  create_table "trackings", force: :cascade do |t|
    t.string "tracking_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.string "description"
    t.string "tracking_status"
    t.string "latest_status"
    t.boolean "failed", default: false
    t.boolean "is_completed", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "password"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.string "password_digest"
    t.boolean "is_signup_request", default: false
    t.string "email"
    t.string "remember_token"
    t.string "account_activation_token"
    t.datetime "account_activation_token_generation_date"
    t.boolean "is_admin", default: false
  end

  add_foreign_key "configurations", "users"
  add_foreign_key "tracking_statuses", "trackings"
  add_foreign_key "trackings", "users"
end
