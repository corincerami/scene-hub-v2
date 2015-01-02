# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150101000357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "band_posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.integer  "band_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bands", force: true do |t|
    t.string  "name",    null: false
    t.integer "user_id", null: false
  end

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "body",       null: false
    t.integer  "show_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genre_lists", force: true do |t|
    t.text    "genres",  null: false, array: true
    t.integer "band_id", null: false
  end

  create_table "gigs", force: true do |t|
    t.integer "show_id"
    t.integer "band_id"
  end

  create_table "photos", force: true do |t|
    t.string   "image_file_name",    null: false
    t.string   "image_content_type", null: false
    t.integer  "image_file_size",    null: false
    t.datetime "image_updated_at",   null: false
    t.integer  "band_id",            null: false
  end

  create_table "shows", force: true do |t|
    t.text     "details"
    t.datetime "show_date", null: false
    t.integer  "venue_id",  null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string "name",                   null: false
    t.string "street_1",               null: false
    t.string "street_2"
    t.string "city",                   null: false
    t.string "state",                  null: false
    t.string "zip_code",               null: false
    t.text   "details"
    t.float  "lat",      default: 0.0, null: false
    t.float  "lng",      default: 0.0, null: false
  end

end
