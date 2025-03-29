# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_19_220418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "position", default: 0
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "active", default: true
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_admins_on_role_id"
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "value"
    t.bigint "response_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["response_id"], name: "index_answers_on_response_id"
  end

  create_table "business_dimensions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_business_dimensions_on_name", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color", default: "#ffffff"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "focus_areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maturity_levels", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "min", default: 15
    t.integer "max", default: 75
    t.string "color", default: "#ffffff"
    t.bigint "questionnaire_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_type_id"], name: "index_maturity_levels_on_questionnaire_type_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "controller", null: false
    t.string "action", default: ""
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller", "action"], name: "index_permissions_on_controller_and_action", unique: true
  end

  create_table "questionnaire_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_questionnaire_types_on_name", unique: true
  end

  create_table "questionnaires", force: :cascade do |t|
    t.bigint "questionnaire_type_id", null: false
    t.string "name"
    t.string "slug"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "show_in_homepage", default: false
    t.index ["questionnaire_type_id"], name: "index_questionnaires_on_questionnaire_type_id"
    t.index ["show_in_homepage"], name: "index_questionnaires_on_show_in_homepage"
    t.index ["slug"], name: "index_questionnaires_on_slug", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.bigint "questionnaire_type_id", null: false
    t.bigint "category_id", null: false
    t.bigint "focus_area_id", null: false
    t.bigint "business_dimension_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_dimension_id"], name: "index_questions_on_business_dimension_id"
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["focus_area_id"], name: "index_questions_on_focus_area_id"
    t.index ["questionnaire_type_id"], name: "index_questions_on_questionnaire_type_id"
  end

  create_table "request_logs", force: :cascade do |t|
    t.string "url", null: false
    t.string "method"
    t.text "request_body"
    t.text "response_body"
    t.integer "response_code"
    t.string "content_type"
    t.integer "content_length", default: 0
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "initiator", default: 0
    t.text "response_headers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "questionnaire_id", null: false
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session"
    t.string "ip_address"
    t.string "user_agent"
    t.index ["person_id"], name: "index_responses_on_person_id"
    t.index ["questionnaire_id"], name: "index_responses_on_questionnaire_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.boolean "allowed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_role_permissions_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.text "descripcion"
    t.string "telefono1"
    t.string "telefono2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "roles"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "responses"
  add_foreign_key "maturity_levels", "questionnaire_types"
  add_foreign_key "questionnaires", "questionnaire_types"
  add_foreign_key "questions", "business_dimensions"
  add_foreign_key "questions", "categories"
  add_foreign_key "questions", "focus_areas"
  add_foreign_key "questions", "questionnaire_types"
  add_foreign_key "responses", "people"
  add_foreign_key "responses", "questionnaires"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
end
