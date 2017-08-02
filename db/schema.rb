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

ActiveRecord::Schema.define(version: 20170802032152) do

  create_table "carts", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "price", null: false
    t.integer "available_inventory", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price"], name: "index_products_on_price"
    t.index ["title"], name: "index_products_on_title"
  end

  create_table "selections", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "cart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_selections_on_cart_id"
    t.index ["product_id"], name: "index_selections_on_product_id"
  end

end
