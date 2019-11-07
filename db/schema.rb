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

ActiveRecord::Schema.define(version: 2019_11_07_151719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", primary_key: "batch_id", id: :serial, comment: "Номер списка посылок", force: :cascade do |t|
    t.string "guid", null: false, comment: "Уникальный номер из файла xml"
    t.datetime "creation_date", null: false, comment: "Дата создания списка посылок"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", primary_key: "invoice_operation_number", id: :serial, force: :cascade do |t|
    t.integer "company_code", null: false
    t.datetime "invoice_operation_date", null: false, comment: "Дата отправки посылки"
    t.bigint "batch_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id_id"], name: "index_invoices_on_batch_id_id"
  end

  create_table "invoices_parcels", force: :cascade do |t|
    t.integer "item_qty", null: false, comment: "Количество товара"
    t.decimal "parcel_price", precision: 7, scale: 2, null: false, comment: "Цена единицы товара для покупателя"
    t.bigint "invoice_operation_number_id"
    t.bigint "parcel_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_operation_number_id"], name: "index_invoices_parcels_on_invoice_operation_number_id"
    t.index ["parcel_code_id"], name: "index_invoices_parcels_on_parcel_code_id"
  end

  create_table "parcels", primary_key: "parcel_code", id: :string, force: :cascade do |t|
    t.string "title", default: "Item_1000000"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
