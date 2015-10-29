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

ActiveRecord::Schema.define(version: 20151029225433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folder_files", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "folder_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "uploaded_file"
  end

  add_index "folder_files", ["folder_id"], name: "index_folder_files_on_folder_id", using: :btree
  add_index "folder_files", ["user_id"], name: "index_folder_files_on_user_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id",          null: false
    t.integer  "parent_folder_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "folders", ["name", "user_id", "parent_folder_id"], name: "index_folders_on_name_and_user_id_and_parent_folder_id", unique: true, using: :btree
  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "sharing_files", force: :cascade do |t|
    t.integer  "folder_file_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "sharing_files", ["folder_file_id"], name: "index_sharing_files_on_folder_file_id", using: :btree
  add_index "sharing_files", ["user_id"], name: "index_sharing_files_on_user_id", using: :btree

  create_table "sharing_folders", force: :cascade do |t|
    t.integer  "folder_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sharing_folders", ["folder_id"], name: "index_sharing_folders_on_folder_id", using: :btree
  add_index "sharing_folders", ["user_id"], name: "index_sharing_folders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "folder_files", "folders"
  add_foreign_key "folder_files", "users"
  add_foreign_key "folders", "folders", column: "parent_folder_id"
  add_foreign_key "folders", "users"
  add_foreign_key "sharing_files", "folder_files"
  add_foreign_key "sharing_files", "users"
  add_foreign_key "sharing_folders", "folders"
  add_foreign_key "sharing_folders", "users"
end
