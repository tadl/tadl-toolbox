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

ActiveRecord::Schema.define(version: 20191107211214) do

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
    t.string   "short_code"
  end

  create_table "incidents", force: :cascade do |t|
    t.datetime "date_of"
    t.string   "location"
    t.string   "department"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.json     "incidentpic"
    t.boolean  "no_patrons"
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.text     "url"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "gender"
    t.integer  "age"
    t.boolean  "no_name"
    t.string   "card_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "no_address"
    t.text     "physical_description"
    t.string   "alias"
    t.json     "patronpic"
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "stat_id"
    t.integer  "value"
    t.string   "last_edit_by"
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

  create_table "suspensions", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "patron_id"
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

  create_table "violations", force: :cascade do |t|
    t.date     "date_issued"
    t.integer  "violationtype_id"
    t.integer  "incident_id"
    t.integer  "patron_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "violations", ["incident_id"], name: "index_violations_on_incident_id", using: :btree
  add_index "violations", ["patron_id"], name: "index_violations_on_patron_id", using: :btree

  create_table "violationtypes", force: :cascade do |t|
    t.string   "description"
    t.string   "first_offence"
    t.string   "second_offence"
    t.string   "subsiquent_offence"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_foreign_key "violations", "incidents"
  add_foreign_key "violations", "patrons"

  create_view "soft_locations", sql_definition: <<-SQL
      SELECT departments.short_code AS shortname,
      departments.name
     FROM departments;
  SQL
  create_view "softstats_reporting_view", sql_definition: <<-SQL
      SELECT reports.report_date AS daterecorded,
      reports.created_at AS dateentered,
      reports.updated_at AS datelastmod,
      departments.short_code AS location,
      reports.last_edit_by AS usercreated,
      reports.last_edit_by AS userlastmod,
      stats.code AS stat,
      reports.value
     FROM ((reports
       JOIN departments ON ((reports.department_id = departments.id)))
       JOIN stats ON ((reports.stat_id = stats.id)));
  SQL
  create_view "soft_statnames", sql_definition: <<-SQL
      SELECT stats.code,
      stats.name,
      stats.group_name AS groupname
     FROM stats;
  SQL
end
