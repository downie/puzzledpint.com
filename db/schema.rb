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

ActiveRecord::Schema.define(version: 20160201010708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "full_name",                           null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_cities", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "city_id"
  end

  add_index "admins_cities", ["admin_id", "city_id"], name: "index_admins_cities_on_admin_id_and_city_id", using: :btree

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "state"
    t.string   "country",    null: false
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["parent_id"], name: "index_cities_on_parent_id", using: :btree

  create_table "event_locations", force: :cascade do |t|
    t.string   "bar_name"
    t.text     "notes"
    t.string   "addr_street_1"
    t.string   "addr_street_2"
    t.string   "addr_city"
    t.string   "addr_state"
    t.string   "addr_postal_code"
    t.string   "addr_country"
    t.integer  "city_id",                                          null: false
    t.integer  "event_id",                                         null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "bar_url"
    t.time     "start_time",       default: '2000-01-01 18:00:00'
  end

  add_index "event_locations", ["city_id"], name: "index_event_locations_on_city_id", using: :btree
  add_index "event_locations", ["event_id"], name: "index_event_locations_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.date     "event_at",   null: false
    t.string   "theme",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "slug",                       null: false
    t.string   "full_path",                  null: false
    t.text     "content",                    null: false
    t.integer  "parent_id"
    t.boolean  "active",     default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["full_path"], name: "index_pages_on_full_path", unique: true, using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

end
