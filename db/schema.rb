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

ActiveRecord::Schema.define(version: 2018_07_05_155424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "address"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "amount_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "ingredients_products", id: false, force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "product_id"
    t.index ["ingredient_id"], name: "index_ingredients_products_on_ingredient_id"
    t.index ["product_id"], name: "index_ingredients_products_on_product_id"
  end

  create_table "ingredients_purchases", id: false, force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "purchase_id", null: false
    t.index ["ingredient_id", "purchase_id"], name: "index_ingredients_purchases_on_ingredient_id_and_purchase_id"
    t.index ["purchase_id", "ingredient_id"], name: "index_ingredients_purchases_on_purchase_id_and_ingredient_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "products_sales", id: false, force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "sale_id", null: false
    t.index ["product_id", "sale_id"], name: "index_products_sales_on_product_id_and_sale_id"
    t.index ["sale_id", "product_id"], name: "index_products_sales_on_sale_id_and_product_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.float "total"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "vendor"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.float "total"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "client"
    t.date "date_of_sale"
    t.index ["user_id"], name: "index_sales_on_user_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "phone_number"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "clients", "users"
  add_foreign_key "ingredients", "users"
  add_foreign_key "products", "users"
  add_foreign_key "purchases", "users"
  add_foreign_key "sales", "users"
  add_foreign_key "vendors", "users"
end
