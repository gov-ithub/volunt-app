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

ActiveRecord::Schema.define(version: 20161205203552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "meetings", force: :cascade do |t|
    t.string   "location",          null: false
    t.string   "agency",            null: false
    t.datetime "date",              null: false
    t.string   "attendees",                      array: true
    t.string   "summary"
    t.text     "notes"
    t.text     "attn_coordinators"
    t.string   "tags",                           array: true
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["date"], name: "index_meetings_on_date", order: {"date"=>:desc}, using: :btree
  end

  create_table "meetings_profiles", id: false, force: :cascade do |t|
    t.integer "meeting_id", null: false
    t.integer "profile_id", null: false
    t.index ["meeting_id"], name: "index_meetings_profiles_on_meeting_id", using: :btree
    t.index ["profile_id"], name: "index_meetings_profiles_on_profile_id", using: :btree
  end

  create_table "openings", force: :cascade do |t|
    t.string   "title",                    null: false
    t.datetime "deadline"
    t.datetime "publish_date"
    t.text     "description"
    t.string   "skills",                                array: true
    t.string   "tags",                                  array: true
    t.integer  "project_id"
    t.text     "experience"
    t.string   "contact"
    t.integer  "status",       default: 0, null: false
    t.integer  "flags",        default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["project_id", "publish_date"], name: "index_openings_on_project_id_and_publish_date", order: {"publish_date"=>:desc}, using: :btree
    t.index ["project_id"], name: "index_openings_on_project_id", using: :btree
    t.index ["publish_date"], name: "index_openings_on_publish_date", order: {"publish_date"=>:desc}, using: :btree
    t.index ["skills"], name: "index_openings_on_skills", using: :gin
    t.index ["tags"], name: "index_openings_on_tags", using: :gin
    t.index ["title"], name: "index_openings_on_title", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name"
    t.string   "nick_name"
    t.string   "email"
    t.json     "contacts"
    t.string   "location"
    t.string   "photo"
    t.string   "curriculum"
    t.text     "description"
    t.jsonb    "urls"
    t.string   "title"
    t.string   "workplace"
    t.string   "tags",                                 array: true
    t.string   "skills",                               array: true
    t.integer  "status",      default: 0, null: false
    t.integer  "flags",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "hidden_tags",                          array: true
    t.index ["email"], name: "index_profiles_on_email", unique: true, using: :btree
    t.index ["full_name"], name: "index_profiles_on_full_name", using: :btree
    t.index ["hidden_tags"], name: "index_profiles_on_hidden_tags", using: :gin
    t.index ["skills"], name: "index_profiles_on_skills", using: :gin
    t.index ["tags"], name: "index_profiles_on_tags", using: :gin
  end

  create_table "project_members", force: :cascade do |t|
    t.string   "role"
    t.integer  "project_id",             null: false
    t.integer  "profile_id",             null: false
    t.integer  "status",     default: 0, null: false
    t.integer  "flags",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["profile_id", "project_id"], name: "index_project_members_on_profile_id_and_project_id", unique: true, using: :btree
    t.index ["profile_id"], name: "index_project_members_on_profile_id", using: :btree
    t.index ["project_id", "profile_id"], name: "index_project_members_on_project_id_and_profile_id", unique: true, using: :btree
    t.index ["project_id"], name: "index_project_members_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",                    null: false
    t.text     "description"
    t.string   "tags",                                 array: true
    t.integer  "status",      default: 0, null: false
    t.integer  "flags",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.jsonb    "urls"
    t.integer  "owner_id"
    t.string   "beneficiary"
    t.text     "objective"
    t.index ["name"], name: "index_projects_on_name", unique: true, using: :btree
    t.index ["owner_id"], name: "index_projects_on_owner_id", using: :btree
    t.index ["tags"], name: "index_projects_on_tags", using: :gin
    t.index ["urls"], name: "index_projects_on_urls", using: :gin
  end

  create_table "status_reports", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "profile_id"
    t.datetime "report_date",             null: false
    t.string   "summary",                 null: false
    t.text     "details"
    t.string   "tags",                                 array: true
    t.integer  "status",      default: 0, null: false
    t.integer  "flags",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_status_reports_on_author_id", using: :btree
    t.index ["profile_id"], name: "index_status_reports_on_profile_id", using: :btree
    t.index ["project_id"], name: "index_status_reports_on_project_id", using: :btree
    t.index ["tags"], name: "index_status_reports_on_tags", using: :gin
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "subject"
    t.text     "body"
    t.string   "tags",                                array: true
    t.integer  "status",     default: 0, null: false
    t.integer  "flags",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_templates_on_name", unique: true, using: :btree
    t.index ["tags"], name: "index_templates_on_tags", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     null: false
    t.binary   "password_hash"
    t.integer  "status",        default: 0, null: false
    t.integer  "flags",         default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "validation_tokens", force: :cascade do |t|
    t.binary   "token",       null: false
    t.integer  "user_id"
    t.integer  "category",    null: false
    t.datetime "valid_until"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["token"], name: "index_validation_tokens_on_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_validation_tokens_on_user_id", using: :btree
  end

  add_foreign_key "meetings_profiles", "meetings"
  add_foreign_key "meetings_profiles", "profiles"
  add_foreign_key "openings", "projects"
  add_foreign_key "project_members", "profiles"
  add_foreign_key "project_members", "projects"
  add_foreign_key "status_reports", "profiles"
  add_foreign_key "status_reports", "profiles", column: "author_id"
  add_foreign_key "status_reports", "projects"
end
