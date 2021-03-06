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

ActiveRecord::Schema.define(version: 20140714153508) do

  create_table "city_codes", force: true do |t|
    t.string   "city_name"
    t.integer  "city_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province"
  end

  create_table "client_nos", force: true do |t|
    t.string   "c_no"
    t.integer  "city_code_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operator_code"
    t.integer  "province"
  end

  create_table "cmcc_cis", force: true do |t|
    t.text     "name"
    t.text     "contact_info"
    t.text     "comment"
    t.text     "mac"
    t.integer  "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", force: true do |t|
    t.string   "name"
    t.string   "contact_info"
    t.string   "comment"
    t.string   "mac"
    t.integer  "company",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tele_cis", force: true do |t|
    t.text     "name"
    t.text     "contact_info"
    t.text     "comment"
    t.text     "mac"
    t.integer  "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_dbs", force: true do |t|
    t.integer  "city_code"
    t.integer  "cs"
    t.integer  "count"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.integer  "month"
    t.integer  "province"
    t.integer  "cmcc_xpon"
    t.integer  "cmcc_status"
    t.integer  "union_xpon"
    t.integer  "union_status"
    t.integer  "tele_xpon"
    t.integer  "tele_status"
  end

  create_table "test_logs", force: true do |t|
    t.string   "cno"
    t.integer  "city_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "province"
  end

  create_table "union_cis", force: true do |t|
    t.text     "name"
    t.text     "contact_info"
    t.text     "comment"
    t.text     "mac"
    t.integer  "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_code_id"
    t.string   "password"
    t.date     "expire_date"
    t.integer  "province"
  end

end
