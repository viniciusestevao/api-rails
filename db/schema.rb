# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_11_02_012904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applies", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "recruiter_id"
    t.datetime "create_date"
    t.string "start_date"
    t.string "finish_date"
    t.string "comment"
    t.index ["candidate_id"], name: "index_applies_on_candidate_id"
    t.index ["recruiter_id"], name: "index_applies_on_recruiter_id"
  end

  create_table "apply_tests", force: :cascade do |t|
    t.bigint "apply_id"
    t.bigint "test_id"
    t.string "title"
    t.string "description"
    t.string "instruction"
    t.index ["apply_id"], name: "index_apply_tests_on_apply_id"
    t.index ["test_id"], name: "index_apply_tests_on_test_id"
  end

  create_table "candidate_answers", force: :cascade do |t|
    t.bigint "test_item_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_item_id"], name: "index_candidate_answers_on_test_item_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "doc_rg"
    t.string "doc_cpf"
    t.string "birth_date"
    t.string "phone_1"
    t.string "phone_2"
    t.string "address_description"
    t.string "address_number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "CEP"
    t.boolean "is_candidate", default: false, null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "tag"
    t.string "description"
    t.string "question_type", null: false
    t.jsonb "body", default: [], null: false
    t.boolean "can_copy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "test_items", force: :cascade do |t|
    t.bigint "apply_test_id"
    t.bigint "question_id"
    t.string "description"
    t.string "question_type", null: false
    t.jsonb "body", default: [], null: false
    t.string "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apply_test_id"], name: "index_test_items_on_apply_test_id"
    t.index ["question_id"], name: "index_test_items_on_question_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "instruction"
    t.boolean "can_copy"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "user_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id"
    t.string "token_type"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email"
    t.boolean "active", default: false, null: false
    t.boolean "is_admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "applies", "people", column: "candidate_id"
  add_foreign_key "applies", "people", column: "recruiter_id"
  add_foreign_key "people", "users"
end
