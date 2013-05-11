# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100522131357) do

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "images", :force => true do |t|
    t.integer "product_id"
    t.string  "name"
    t.string  "picture"
  end

  create_table "line_items", :force => true do |t|
    t.integer "product_id"
    t.integer "quantity"
    t.float   "unit_price"
    t.integer "order_id"
    t.integer "status"
  end

  create_table "orders", :force => true do |t|
    t.integer "user_id"
    t.date    "order_date"
    t.integer "status"
    t.string  "order_no"
    t.float   "shipping_cost"
    t.string  "pay_type"
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.float   "price"
    t.integer "category_id"
    t.text    "description"
    t.string  "product_code"
    t.boolean "available",    :default => true
  end

  create_table "users", :force => true do |t|
    t.string  "title"
    t.string  "firstname"
    t.string  "lastname"
    t.string  "email"
    t.string  "password"
    t.string  "address1"
    t.string  "address2"
    t.string  "address3"
    t.boolean "admin",     :default => false
  end

end
