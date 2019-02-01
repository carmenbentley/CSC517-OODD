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

ActiveRecord::Schema.define(version: 2018_09_30_205712) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "houses", force: :cascade do |t|
    t.string "location", null: false
    t.decimal "square_footage", null: false
    t.integer "year_built", null: false
    t.string "style", null: false
    t.decimal "list_price", null: false
    t.integer "num_floors", null: false
    t.boolean "basement", null: false
    t.integer "real_estate_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "realtor_id"
    t.string "owner"
    t.index ["real_estate_company_id"], name: "index_houses_on_real_estate_company_id"
    t.index ["realtor_id"], name: "index_houses_on_realtor_id"
  end

  create_table "houses_hunters", id: false, force: :cascade do |t|
    t.integer "house_id"
    t.integer "hunter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_houses_hunters_on_house_id"
    t.index ["hunter_id"], name: "index_houses_hunters_on_hunter_id"
  end

  create_table "hunter_makes_inquiries", force: :cascade do |t|
    t.integer "hunter_id"
    t.integer "inquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hunter_id"], name: "index_hunter_makes_inquiries_on_hunter_id"
    t.index ["inquiry_id"], name: "index_hunter_makes_inquiries_on_inquiry_id"
  end

  create_table "hunters", force: :cascade do |t|
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
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.string "preferred", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.index ["email"], name: "index_hunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hunters_on_reset_password_token", unique: true
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "subject"
    t.string "message"
    t.integer "house_id"
    t.integer "hunter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reply"
    t.integer "realtor_id"
    t.index ["house_id"], name: "index_inquiries_on_house_id"
    t.index ["hunter_id"], name: "index_inquiries_on_hunter_id"
    t.index ["realtor_id"], name: "index_inquiries_on_realtor_id"
  end

  create_table "real_estate_companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "website", null: false
    t.string "address", null: false
    t.integer "size", null: false
    t.integer "founded", null: false
    t.decimal "revenue", null: false
    t.string "synopsis", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "realtor_replies_to_inquiries", force: :cascade do |t|
    t.integer "realtor_id"
    t.integer "inquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inquiry_id"], name: "index_realtor_replies_to_inquiries_on_inquiry_id"
    t.index ["realtor_id"], name: "index_realtor_replies_to_inquiries_on_realtor_id"
  end

  create_table "realtors", force: :cascade do |t|
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
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.integer "real_estate_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.index ["email"], name: "index_realtors_on_email", unique: true
    t.index ["real_estate_company_id"], name: "index_realtors_on_real_estate_company_id"
    t.index ["reset_password_token"], name: "index_realtors_on_reset_password_token", unique: true
  end

end
