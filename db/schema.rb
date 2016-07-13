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

ActiveRecord::Schema.define(version: 20150502035130) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "provider_codes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.integer  "user_id"
    t.integer  "provider_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "user_name",   limit: 255
    t.string   "email",       limit: 255
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "history",       limit: 255
    t.string   "provider",      limit: 255
    t.string   "email",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "usedCodes"
    t.integer  "uploadedCodes"
    t.integer  "unclaimCodes"
    t.integer  "removedCodes"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
    t.string   "email",      limit: 255
  end

  create_table "vendor_codes", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "vendor",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "vendor_id"
    t.integer  "user_id"
    t.string   "name",       limit: 255
    t.string   "user_name",  limit: 255
    t.string   "email",      limit: 255
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "uid",           limit: 255
    t.string   "provider",      limit: 255
    t.string   "description",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "email",         limit: 255
    t.string   "history",       limit: 255
    t.string   "website",       limit: 255
    t.string   "instruction",   limit: 255
    t.string   "helpLink",      limit: 255
    t.string   "cashValue",     limit: 255
    t.string   "expiration",    limit: 255
    t.integer  "usedCodes"
    t.integer  "uploadedCodes"
    t.integer  "unclaimCodes"
    t.integer  "removedCodes"
  end

end
