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

ActiveRecord::Schema.define(version: 20161128132255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "locale"
    t.string "timezone"
  end

  create_table "forms_response_fields", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "field_type"
    t.string   "block_key"
    t.text     "content"
    t.integer  "score"
    t.boolean  "autocheck"
    t.text     "user_content"
    t.integer  "user_score"
    t.boolean  "checked",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["question_id"], name: "index_forms_response_fields_on_question_id", using: :btree
  end

  create_table "forms_response_options", force: :cascade do |t|
    t.string   "content"
    t.boolean  "is_correct"
    t.integer  "field_id"
    t.integer  "order_index"
    t.boolean  "user_selected"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["field_id"], name: "index_forms_response_options_on_field_id", using: :btree
  end

  create_table "forms_response_questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "section_id"
    t.integer  "order_index"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["section_id"], name: "index_forms_response_questions_on_section_id", using: :btree
  end

  create_table "forms_response_sections", force: :cascade do |t|
    t.string   "title"
    t.integer  "time_limit"
    t.integer  "response_id"
    t.text     "description"
    t.integer  "required_score"
    t.string   "uuid"
    t.integer  "score_units"
    t.integer  "order_index"
    t.integer  "acceptable_score"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "bonus_time"
    t.index ["response_id"], name: "index_forms_response_sections_on_response_id", using: :btree
  end

  create_table "forms_responses", force: :cascade do |t|
    t.string   "name"
    t.integer  "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["test_id"], name: "index_forms_responses_on_test_id", using: :btree
    t.index ["user_id"], name: "index_forms_responses_on_user_id", using: :btree
  end

  create_table "forms_test_fields", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "field_type"
    t.string   "block_key"
    t.text     "content"
    t.integer  "score"
    t.boolean  "autocheck"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_forms_test_fields_on_question_id", using: :btree
  end

  create_table "forms_test_options", force: :cascade do |t|
    t.string   "content"
    t.boolean  "is_correct"
    t.integer  "field_id"
    t.integer  "order_index"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["field_id"], name: "index_forms_test_options_on_field_id", using: :btree
  end

  create_table "forms_test_questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "order_index"
    t.integer  "section_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["section_id"], name: "index_forms_test_questions_on_section_id", using: :btree
  end

  create_table "forms_test_sections", force: :cascade do |t|
    t.integer  "test_id"
    t.string   "title"
    t.text     "description"
    t.integer  "time_limit"
    t.integer  "bonus_time"
    t.integer  "required_score"
    t.integer  "required_score_units"
    t.integer  "acceptable_score"
    t.integer  "acceptable_score_units"
    t.integer  "order_index"
    t.boolean  "shuffle_questions"
    t.integer  "questions_to_show"
    t.integer  "show_next_section"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["test_id"], name: "index_forms_test_sections_on_test_id", using: :btree
  end

  create_table "forms_tests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transliterations", force: :cascade do |t|
    t.string "russian"
    t.string "english"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                                                                             null: false
    t.string   "encrypted_password",     default: "",                                                                             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                                                              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                                                                                      null: false
    t.datetime "updated_at",                                                                                                      null: false
    t.integer  "city_id"
    t.string   "timezone"
    t.jsonb    "names",                  default: {"last_name"=>"", "first_name"=>"", "last_name_eng"=>"", "first_name_eng"=>""}
    t.integer  "staff_id"
    t.integer  "recruitment_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "forms_responses", "users"
end
