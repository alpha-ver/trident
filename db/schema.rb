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

ActiveRecord::Schema.define(version: 20170314082553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champs", force: :cascade do |t|
    t.string   "name"
    t.string   "find_names",      default: [],              array: true
    t.string   "created"
    t.integer  "sport_id"
    t.integer  "country_id"
    t.integer  "api_xbet_id"
    t.json     "api_xbet_params"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "api_leon_id"
    t.json     "api_leon_params"
  end

  create_table "commands", force: :cascade do |t|
    t.string   "name"
    t.string   "find_names",  default: [],              array: true
    t.string   "created"
    t.integer  "sport_id"
    t.integer  "api_xbet_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "find_names",      default: [],              array: true
    t.string   "created"
    t.integer  "api_xbet_id"
    t.json     "api_xbet_params"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "group"
    t.string   "name"
    t.string   "type"
    t.integer  "v_i"
    t.string   "v_s"
    t.text     "v_t"
    t.json     "v_j"
    t.boolean  "v_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sports", force: :cascade do |t|
    t.string   "name"
    t.string   "find_names",      default: [],                array: true
    t.string   "created"
    t.boolean  "enable",          default: true
    t.integer  "api_xbet_id"
    t.json     "api_xbet_params"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "api_leon_id"
    t.json     "api_leon_params"
  end

  create_table "xbet_betgroups", force: :cascade do |t|
    t.string   "name"
    t.integer  "pos"
    t.integer  "countcols"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xbet_bets", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "bettype_id"
    t.float    "ratio"
    t.boolean  "active"
    t.float    "p"
    t.json     "pl"
    t.json     "dl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xbet_bettypes", force: :cascade do |t|
    t.string   "name"
    t.integer  "col"
    t.integer  "colpos"
    t.integer  "groupnamevid"
    t.integer  "typeparam"
    t.integer  "betgroup_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "xbet_events", force: :cascade do |t|
    t.integer  "champ_id"
    t.integer  "const_id"
    t.integer  "contora"
    t.string   "dopinfo"
    t.boolean  "finish"
    t.integer  "maingame_id"
    t.integer  "num"
    t.integer  "period"
    t.integer  "host_command_id"
    t.integer  "slave_command_id"
    t.integer  "commands_ids"
    t.integer  "status"
    t.json     "score_history"
    t.json     "message_history"
    t.json     "dl"
    t.datetime "start_at"
    t.json     "score"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
