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

ActiveRecord::Schema.define(version: 20141007211234) do

  create_table "games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: true do |t|
    t.integer "game_id"
    t.integer "index"
    t.integer "nbr_participants"
    t.integer "nbr_fails_required", default: 1
  end

  add_index "missions", ["game_id"], name: "index_missions_on_game_id"

  create_table "nominations", force: true do |t|
    t.integer  "mission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nominations", ["mission_id"], name: "index_nominations_on_mission_id"

  create_table "nominations_players", force: true do |t|
    t.integer "nomination_id"
    t.integer "player_id"
  end

  create_table "players", force: true do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.string  "team"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"
  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "votes", force: true do |t|
    t.integer  "nomination_id"
    t.integer  "player_id"
    t.boolean  "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["nomination_id"], name: "index_votes_on_nomination_id"

end
