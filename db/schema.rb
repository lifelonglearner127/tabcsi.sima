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

ActiveRecord::Schema.define(version: 2018_07_18_161315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.text "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_on_record_and_name_and_blob", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.text "filename", null: false
    t.text "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.text "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "license_number", null: false
    t.text "answer_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_answers_on_discarded_at"
    t.index ["license_number"], name: "index_answers_on_license_number"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "audit_form_questions", force: :cascade do |t|
    t.bigint "audit_form_id", null: false
    t.bigint "question_id", null: false
    t.boolean "finish", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["audit_form_id", "question_id"], name: "index_audit_form_questions_on_audit_form_id_and_question_id", unique: true
    t.index ["discarded_at"], name: "index_audit_form_questions_on_discarded_at"
    t.index ["question_id", "audit_form_id"], name: "index_audit_form_questions_on_question_id_and_audit_form_id", unique: true
  end

  create_table "audit_forms", force: :cascade do |t|
    t.string "permit_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_audit_forms_on_discarded_at"
    t.index ["permit_name"], name: "index_audit_forms_on_permit_name", unique: true
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "choice_text", null: false
    t.boolean "picture_attachment", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_choices_on_discarded_at"
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "condition_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "conditional_question_number", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_conditions_on_discarded_at"
    t.index ["question_id"], name: "index_conditions_on_question_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "licenses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "license_number", null: false
    t.decimal "front_lat", null: false
    t.decimal "front_long", null: false
    t.decimal "back_lat", null: false
    t.decimal "back_long", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_licenses_on_discarded_at"
    t.index ["license_number"], name: "index_licenses_on_license_number"
    t.index ["user_id"], name: "index_licenses_on_user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.text "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confidential", default: true, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "push_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "device_type", null: false
    t.text "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_push_tokens_on_discarded_at"
    t.index ["user_id", "token"], name: "index_push_tokens_on_user_id_and_token", unique: true
    t.index ["user_id"], name: "index_push_tokens_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_number", null: false
    t.text "question_text", null: false
    t.integer "question_type", null: false
    t.integer "max_characters", default: 0, null: false
    t.boolean "multiline", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_questions_on_discarded_at"
    t.index ["question_number"], name: "index_questions_on_question_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.bigint "version_id", null: false
    t.string "foreign_key_name", null: false
    t.bigint "foreign_key_id", null: false
    t.index ["foreign_key_id"], name: "index_version_associations_on_foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at", null: false
    t.bigint "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "audit_form_questions", "audit_forms"
  add_foreign_key "audit_form_questions", "questions"
  add_foreign_key "choices", "questions"
  add_foreign_key "conditions", "questions"
  add_foreign_key "licenses", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "push_tokens", "users"
  add_foreign_key "version_associations", "versions"
end
