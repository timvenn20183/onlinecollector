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

ActiveRecord::Schema.define(version: 20160912154241) do

  create_table "datafiles", force: :cascade do |t|
    t.string   "name"
    t.integer  "site_id"
    t.integer  "item_id"
    t.string   "data"
    t.string   "slug"
    t.text     "filetype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fieldoptions", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "itemfield_id"
    t.integer  "site_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "fieldoptions_items", id: false, force: :cascade do |t|
    t.integer "fieldoption_id"
    t.integer "item_id"
    t.index ["fieldoption_id", "item_id"], name: "fieldoptions_items_index", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "imagefiles", force: :cascade do |t|
    t.string   "name"
    t.integer  "site_id"
    t.integer  "item_id"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itemfields", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "site_id"
    t.boolean  "required",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "alphabet_letter", limit: 1
    t.integer  "site_id"
    t.date     "acquired_date"
    t.date     "removed_date"
    t.string   "collectionid"
    t.text     "note"
    t.text     "searchstring"
    t.integer  "views",                     default: 0
    t.text     "prefs"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "subdomain"
    t.string   "title"
    t.string   "activationkey"
    t.text     "prefs"
    t.text     "tracking_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.integer  "site_id"
    t.integer  "role",       default: 1
    t.string   "appkey"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
