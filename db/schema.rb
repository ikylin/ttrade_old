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

ActiveRecord::Schema.define(version: 20140903072437) do

  create_table "accounts", force: true do |t|
    t.date     "setdate"
    t.string   "name"
    t.integer  "tradenum"
    t.decimal  "winratio",            precision: 5, scale: 2
    t.decimal  "plratio",             precision: 5, scale: 2
    t.decimal  "profitmax",           precision: 6, scale: 2
    t.decimal  "lossmax",             precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "marketdate"
    t.integer  "duration"
    t.integer  "wincount"
    t.integer  "losscount"
    t.decimal  "profit",              precision: 5, scale: 2
    t.integer  "pretradenum"
    t.decimal  "preprofit",           precision: 5, scale: 2
    t.integer  "prewincount"
    t.integer  "prelosscount"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "analyst_id"
  end

  create_table "analysts", force: true do |t|
    t.string   "name"
    t.string   "lvl"
    t.integer  "fan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "everydaytips", force: true do |t|
    t.text     "tip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marketdates", force: true do |t|
    t.date     "tradedate"
    t.string   "daystate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "odsreserves", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "plate"
    t.decimal  "open",       precision: 6, scale: 2
    t.decimal  "high",       precision: 6, scale: 2
    t.decimal  "low",        precision: 6, scale: 2
    t.decimal  "close",      precision: 6, scale: 2
    t.decimal  "dprofit",    precision: 5, scale: 2
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfoliologs", force: true do |t|
    t.string   "opt"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolios", force: true do |t|
    t.date     "buydate"
    t.decimal  "buyprice",     precision: 6, scale: 2
    t.decimal  "profit",       precision: 6, scale: 2
    t.decimal  "volum",        precision: 2, scale: 1
    t.string   "option"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "quotation_id"
    t.date     "marketdate"
    t.date     "selldate"
    t.decimal  "sellprice",    precision: 6, scale: 2
    t.integer  "duration"
  end

  create_table "quotationdatafiles", force: true do |t|
    t.string   "filetype"
    t.string   "filestatus"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "marketdate"
  end

  create_table "quotations", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "plate"
    t.decimal  "open",       precision: 6, scale: 2
    t.decimal  "high",       precision: 6, scale: 2
    t.decimal  "low",        precision: 6, scale: 2
    t.decimal  "close",      precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "marketdate"
    t.decimal  "dprofit",    precision: 5, scale: 2
    t.string   "tpstatus"
    t.string   "cqstatus"
  end

  create_table "reserves", force: true do |t|
    t.string   "stockstatus"
    t.decimal  "hhv",          precision: 6, scale: 2
    t.decimal  "llv",          precision: 6, scale: 2
    t.date     "hdate"
    t.date     "ldate"
    t.decimal  "profit",       precision: 6, scale: 2
    t.decimal  "loss",         precision: 6, scale: 2
    t.decimal  "plratio",      precision: 6, scale: 2
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quotation_id"
    t.date     "marketdate"
    t.string   "optadvise"
    t.integer  "lvladvise"
    t.integer  "analyst_id"
    t.integer  "duration"
    t.date     "catchdate"
    t.date     "releasedate"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sysconfigs", force: true do |t|
    t.date     "cfgdate"
    t.time     "cfgtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cfgname"
    t.integer  "cfginteger"
    t.string   "cfgstring"
    t.text     "cfgtext"
    t.integer  "lock_version"
  end

  create_table "syslogs", force: true do |t|
    t.string   "role"
    t.datetime "time"
    t.string   "opt"
    t.string   "curstate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "openid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "weixinstatus"
    t.date     "guanzhudate"
    t.date     "quxiaoguanzhudate"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "weixinlogs", force: true do |t|
    t.datetime "time"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
