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

ActiveRecord::Schema.define(version: 20170610192511) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 1048576
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"

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

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
  end

  add_index "brands", ["slug"], name: "index_brands_on_slug", unique: true

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "interest"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true

  create_table "deals", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "description",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "special"
    t.integer  "trigger_product_id"
    t.decimal  "price"
  end

  add_index "deals", ["product_id"], name: "index_deals_on_product_id"
  add_index "deals", ["trigger_product_id"], name: "index_deals_on_trigger_product_id"

  create_table "deployments", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "status",                      limit: 255
    t.integer  "prefix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "machine_learning_service_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "machine_learning_services", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content",         limit: 255
    t.boolean  "watson_response"
    t.integer  "customer_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "messages", ["customer_id"], name: "index_messages_on_customer_id"

  create_table "ml_scoring_param_options", force: :cascade do |t|
    t.integer "ml_scoring_param_id"
    t.string  "value",               limit: 255
  end

  add_index "ml_scoring_param_options", ["ml_scoring_param_id"], name: "index_ml_scoring_param_options_on_ml_scoring_param_id"

  create_table "ml_scoring_params", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "brand_id"
    t.boolean  "preorder"
    t.decimal  "price"
    t.string   "slug"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true

  create_table "trending_topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "frequency"
    t.integer  "aphone"
    t.integer  "sphone"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trending_topics", ["product_id"], name: "index_trending_topics_on_product_id"

end
