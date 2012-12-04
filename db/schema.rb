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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121204021406) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "announcement_type", :default => "notice"
  end

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "idiom_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "conversations", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "initiator_id"
    t.integer  "receiver_id"
  end

  create_table "edits", :force => true do |t|
    t.integer  "idiom_id"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "edited_at"
    t.text     "description_right"
    t.string   "summary"
  end

  create_table "idioms", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "user_id"
    t.text     "description_right", :limit => 255
    t.string   "summary"
  end

  create_table "inboxes", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "meetups", :force => true do |t|
    t.string   "name"
    t.string   "group_name"
    t.string   "event_url"
    t.text     "description"
    t.datetime "meetup_time"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "attending"
    t.integer  "idiom_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "event_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
  end

  create_table "messages", :force => true do |t|
    t.datetime "read_at"
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "redactor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "reports", :force => true do |t|
    t.string   "reportable_type"
    t.integer  "reportable_id"
    t.integer  "user_id"
    t.text     "message"
    t.boolean  "resolved",        :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "reports", ["reportable_id", "reportable_type"], :name => "index_reports_on_reportable_id_and_reportable_type"

  create_table "tag_associations", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "idiom_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "about_me"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.integer  "uid"
    t.string   "provider"
    t.boolean  "admin",           :default => false
    t.datetime "deleted_at"
    t.boolean  "banned",          :default => false
    t.boolean  "receive_emails"
    t.string   "zip_code"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "vote_value",    :default => 0
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"

end
