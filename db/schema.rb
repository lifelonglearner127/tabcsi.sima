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

ActiveRecord::Schema.define(version: 2018_10_29_235504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_logs", force: :cascade do |t|
    t.string "sequence_id", null: false
    t.string "tag", null: false
    t.text "message", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_action_logs_on_discarded_at"
  end

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
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.bigint "inspection_id", null: false
    t.bigint "question_id", null: false
    t.index ["discarded_at"], name: "index_answers_on_discarded_at"
    t.index ["inspection_id", "question_id"], name: "index_answers_on_inspection_id_and_question_id", unique: true
    t.index ["inspection_id"], name: "index_answers_on_inspection_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "audit_form_questions", force: :cascade do |t|
    t.bigint "audit_form_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_audit_form_questions_on_discarded_at"
  end

  create_table "audit_forms", force: :cascade do |t|
    t.string "permit_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_audit_forms_on_discarded_at"
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

  create_table "companies", force: :cascade do |t|
    t.text "name"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "owner_name", null: false
    t.boolean "owned", default: false, null: false
    t.index ["discarded_at"], name: "index_companies_on_discarded_at"
    t.index ["owner_name"], name: "index_companies_on_owner_name", unique: true
  end

  create_table "conditions", force: :cascade do |t|
    t.string "condition_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "conditional_question_number"
    t.datetime "discarded_at"
    t.bigint "audit_form_question_id", null: false
    t.index ["audit_form_question_id"], name: "index_conditions_on_audit_form_question_id"
    t.index ["discarded_at"], name: "index_conditions_on_discarded_at"
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

  create_table "fields", force: :cascade do |t|
    t.bigint "choice_id", null: false
    t.string "label", null: false
    t.integer "field_type", default: 0, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_fields_on_choice_id"
    t.index ["discarded_at"], name: "index_fields_on_discarded_at"
  end

  create_table "inspections", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "audit_form_id", null: false
    t.bigint "user_id", null: false
    t.datetime "started_at", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.datetime "finished_at"
    t.datetime "submitted_at"
    t.string "report_number"
    t.text "cancellation_reason"
    t.datetime "cancelled_at"
    t.bigint "license_id"
    t.boolean "erroneous", default: false, null: false
    t.string "fiscal_year"
    t.boolean "flagged"
    t.text "flag_reason"
    t.datetime "flagged_at"
    t.index ["audit_form_id"], name: "index_inspections_on_audit_form_id"
    t.index ["completed_at", "submitted_at", "erroneous"], name: "index_inspections_on_unsubmitted"
    t.index ["completed_at"], name: "index_inspections_on_completed_at"
    t.index ["discarded_at"], name: "index_inspections_on_discarded_at"
    t.index ["erroneous"], name: "index_inspections_on_erroneous"
    t.index ["fiscal_year"], name: "index_inspections_on_fiscal_year"
    t.index ["flagged"], name: "index_inspections_on_flagged"
    t.index ["license_id"], name: "index_inspections_on_license_id"
    t.index ["location_id"], name: "index_inspections_on_location_id"
    t.index ["submitted_at"], name: "index_inspections_on_submitted_at"
    t.index ["user_id"], name: "index_inspections_on_user_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.integer "license_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.bigint "company_id", null: false
    t.bigint "location_id", null: false
    t.string "license_type", null: false
    t.string "subordinate"
    t.string "related_to"
    t.string "status", null: false
    t.date "expires_on"
    t.string "clp"
    t.index ["clp"], name: "index_licenses_on_clp", unique: true
    t.index ["company_id"], name: "index_licenses_on_company_id"
    t.index ["discarded_at"], name: "index_licenses_on_discarded_at"
    t.index ["license_type", "license_number"], name: "index_licenses_on_license_type_and_license_number", unique: true
    t.index ["location_id"], name: "index_licenses_on_location_id"
  end

  create_table "licenses_users", id: false, force: :cascade do |t|
    t.bigint "license_id", null: false
    t.bigint "user_id", null: false
    t.index ["license_id", "user_id"], name: "index_licenses_users_on_license_id_and_user_id"
    t.index ["user_id", "license_id"], name: "index_licenses_users_on_user_id_and_license_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name", null: false
    t.text "address1", null: false
    t.text "address2"
    t.text "address3"
    t.string "city", null: false
    t.string "county"
    t.string "state"
    t.string "country", null: false
    t.string "postal_code", null: false
    t.decimal "front_lat"
    t.decimal "front_long"
    t.decimal "back_lat"
    t.decimal "back_long"
    t.boolean "locked", default: false, null: false
    t.string "phone_number"
    t.integer "tabc_id"
    t.boolean "inspected", default: false, null: false
    t.bigint "locked_by_id"
    t.decimal "unpadded_diameter"
    t.decimal "padded_diameter"
    t.string "clp"
    t.datetime "locked_at"
    t.datetime "inspected_at"
    t.bigint "inspected_by_id"
    t.index ["clp"], name: "index_locations_on_clp", unique: true
    t.index ["company_id"], name: "index_locations_on_company_id"
    t.index ["discarded_at"], name: "index_locations_on_discarded_at"
    t.index ["inspected_by_id"], name: "index_locations_on_inspected_by_id"
    t.index ["locked_by_id"], name: "index_locations_on_locked_by_id"
    t.index ["tabc_id"], name: "index_locations_on_tabc_id", unique: true
  end

  create_table "locations_users", id: false, force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "user_id", null: false
    t.index ["location_id", "user_id"], name: "index_locations_users_on_location_id_and_user_id"
    t.index ["user_id", "location_id"], name: "index_locations_users_on_user_id_and_location_id"
  end

  create_table "news", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "news_type", default: 0, null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_news_on_discarded_at"
    t.index ["news_type"], name: "index_news_on_news_type"
    t.index ["user_id"], name: "index_news_on_user_id"
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
    t.index ["device_type"], name: "index_push_tokens_on_device_type"
    t.index ["discarded_at"], name: "index_push_tokens_on_discarded_at"
    t.index ["user_id", "token"], name: "index_push_tokens_on_user_id_and_token", unique: true
    t.index ["user_id"], name: "index_push_tokens_on_user_id"
  end

  create_table "question_help_images", force: :cascade do |t|
    t.string "parent_type", null: false
    t.bigint "parent_id", null: false
    t.string "path", null: false
    t.integer "sort_order", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_question_help_images_on_discarded_at"
    t.index ["parent_type", "parent_id"], name: "index_question_help_images_on_parent_type_and_parent_id"
    t.index ["sort_order"], name: "index_question_help_images_on_sort_order"
  end

  create_table "question_help_items", force: :cascade do |t|
    t.string "parent_type", null: false
    t.bigint "parent_id", null: false
    t.text "value", null: false
    t.integer "sort_order", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_question_help_items_on_discarded_at"
    t.index ["parent_type", "parent_id"], name: "index_question_help_items_on_parent_type_and_parent_id"
    t.index ["sort_order"], name: "index_question_help_items_on_sort_order"
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
    t.text "source"
    t.integer "other"
    t.boolean "multiple", default: false, null: false
    t.string "label"
    t.string "additional_label"
    t.integer "additional_text"
    t.integer "additional_type"
    t.date "built_on"
    t.index ["built_on", "question_number"], name: "index_questions_on_built_on_and_question_number", unique: true
    t.index ["discarded_at"], name: "index_questions_on_discarded_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.text "value"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_settings_on_discarded_at"
    t.index ["name"], name: "index_settings_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.bigint "company_id"
    t.text "full_name", default: "", null: false
    t.string "phone"
    t.string "job_title"
    t.integer "role", default: 1, null: false
    t.datetime "pin_last_requested_at"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "answers", "inspections"
  add_foreign_key "answers", "questions"
  add_foreign_key "audit_form_questions", "audit_forms"
  add_foreign_key "audit_form_questions", "questions"
  add_foreign_key "choices", "questions"
  add_foreign_key "conditions", "audit_form_questions"
  add_foreign_key "fields", "choices"
  add_foreign_key "inspections", "audit_forms"
  add_foreign_key "inspections", "licenses"
  add_foreign_key "inspections", "locations"
  add_foreign_key "inspections", "users"
  add_foreign_key "licenses", "companies"
  add_foreign_key "licenses", "locations"
  add_foreign_key "locations", "companies"
  add_foreign_key "news", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "push_tokens", "users"
  add_foreign_key "users", "companies"
end
