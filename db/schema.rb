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

ActiveRecord::Schema.define(version: 2020_02_26_171056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "adresse"
    t.string "email"
    t.string "telephone"
    t.string "raison_sociale"
    t.string "siret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "adresse"
    t.string "tel"
    t.string "sexe"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "code_promos", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "note"
    t.text "content"
    t.string "user_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.bigint "country_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_departments_on_country_id"
  end

  create_table "massage_cas", force: :cascade do |t|
    t.string "name"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_massage_cas_on_service_id"
  end

  create_table "massage_su_prices", force: :cascade do |t|
    t.integer "duration"
    t.float "exceptional_price"
    t.float "ordinary_price"
    t.float "exceptional_acompte"
    t.float "ordinary_acompte"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "massage_sus", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "massage_ca_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["massage_ca_id"], name: "index_massage_sus_on_massage_ca_id"
  end

  create_table "order_massages", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "massage_ca_id"
    t.bigint "massage_su_id"
    t.bigint "massage_su_price_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["massage_ca_id"], name: "index_order_massages_on_massage_ca_id"
    t.index ["massage_su_id"], name: "index_order_massages_on_massage_su_id"
    t.index ["massage_su_price_id"], name: "index_order_massages_on_massage_su_price_id"
    t.index ["order_id"], name: "index_order_massages_on_order_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "number"
    t.bigint "product_id"
    t.bigint "order_id"
    t.bigint "order_spa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["order_spa_id"], name: "index_order_products_on_order_spa_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "order_services", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_services_on_order_id"
    t.index ["service_id"], name: "index_order_services_on_service_id"
  end

  create_table "order_spas", force: :cascade do |t|
    t.string "logement"
    t.string "installation"
    t.string "syteme_eau"
    t.bigint "order_id"
    t.bigint "spa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_spas_on_order_id"
    t.index ["spa_id"], name: "index_order_spas_on_spa_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "prestation_date"
    t.time "prestation_time"
    t.string "billing_pays"
    t.string "billing_ville"
    t.string "billing_code_postal"
    t.string "billing_adresse"
    t.string "delivery_pays"
    t.string "delivery_ville"
    t.string "delivery_code_postal"
    t.string "delivery_adresse"
    t.string "praticien"
    t.text "message"
    t.bigint "client_id"
    t.bigint "department_id"
    t.bigint "country_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["country_id"], name: "index_orders_on_country_id"
    t.index ["department_id"], name: "index_orders_on_department_id"
  end

  create_table "other_su_prices", force: :cascade do |t|
    t.bigint "massage_su_id"
    t.bigint "massage_su_price_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["massage_su_id"], name: "index_other_su_prices_on_massage_su_id"
    t.index ["massage_su_price_id"], name: "index_other_su_prices_on_massage_su_price_id"
  end

  create_table "prestataire_departments", force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "prestataire_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_prestataire_departments_on_department_id"
    t.index ["prestataire_id"], name: "index_prestataire_departments_on_prestataire_id"
  end

  create_table "prestataire_services", force: :cascade do |t|
    t.bigint "prestataire_id"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prestataire_id"], name: "index_prestataire_services_on_prestataire_id"
    t.index ["service_id"], name: "index_prestataire_services_on_service_id"
  end

  create_table "prestataires", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "adresse"
    t.string "tel"
    t.string "raison_sociale"
    t.string "siret"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.boolean "is_option_spa", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spas", force: :cascade do |t|
    t.integer "duration"
    t.float "exceptional_price"
    t.float "ordinary_price"
    t.float "exceptional_acompte"
    t.float "ordinary_acompte"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_spas_on_service_id"
  end

end
