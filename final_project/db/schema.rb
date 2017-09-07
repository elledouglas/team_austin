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

ActiveRecord::Schema.define(version: 20170905201115) do

  create_table "block_relationships", force: :cascade do |t|
    t.integer "blocker_id"
    t.integer "blocked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_block_relationships_on_blocked_id"
    t.index ["blocker_id", "blocked_id"], name: "index_block_relationships_on_blocker_id_and_blocked_id", unique: true
    t.index ["blocker_id"], name: "index_block_relationships_on_blocker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "full_name"
    t.string "email"
    t.integer "age"
    t.string "gender"
    t.integer "children"
    t.string "sexual_preference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "video"
    t.string "remember_digest"
    t.string "occupation"
    t.string "image"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "instagram_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "winks", force: :cascade do |t|
    t.integer "wink_sender_id"
    t.integer "wink_recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wink_recipient_id"], name: "index_winks_on_wink_recipient_id"
    t.index ["wink_sender_id", "wink_recipient_id"], name: "index_winks_on_wink_sender_id_and_wink_recipient_id"
    t.index ["wink_sender_id"], name: "index_winks_on_wink_sender_id"
  end

end
