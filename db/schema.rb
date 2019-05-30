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

ActiveRecord::Schema.define(version: 20190530190359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "email"
  end

  create_table "covers", force: :cascade do |t|
    t.integer  "record_id"
    t.string   "source"
    t.integer  "admin_id"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "title"
    t.text     "artist"
    t.string   "publisher"
    t.string   "release_date"
    t.string   "item_type"
    t.text     "track_list"
    t.text     "abstract"
    t.string   "coverart"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active",     default: true
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.text     "url"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "stat_id"
    t.integer  "value"
    t.integer  "last_edit_by"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "report_date"
  end

  create_table "stats", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "group_name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trailers", force: :cascade do |t|
    t.integer  "record_id"
    t.string   "added_by"
    t.string   "youtube_url"
    t.string   "release_date"
    t.string   "title"
    t.string   "artist"
    t.string   "publisher"
    t.text     "abstract"
    t.string   "item_type"
    t.text     "track_list"
    t.boolean  "cant_find",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "admin_id"
  end

end
