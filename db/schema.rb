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

ActiveRecord::Schema.define(version: 2020_08_11_132024) do

  create_table "manuals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_manuals_on_user_id"
  end

  create_table "my_trucks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "my_kanji"
    t.string "my_up_num"
    t.string "my_hiragana"
    t.string "my_btm_left_num"
    t.string "my_btm_right_num"
    t.string "my_truck_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_my_trucks_on_user_id"
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cntr_number"
    t.string "truck_number"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purpose"
    t.integer "ps_card"
    t.bigint "slot_id"
    t.bigint "user_id"
    t.string "ordered_end_time"
    t.string "ordered_begin_time"
    t.string "ordered_name"
    t.string "ordered_tel"
    t.integer "allowance"
    t.string "pass_code"
    t.string "ordered_company"
    t.string "ordered_email"
    t.index ["slot_id"], name: "index_orders_on_slot_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "powers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "login_switch"
    t.integer "update_switch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "begin_time"
    t.string "end_time"
    t.string "max_num"
    t.integer "vip"
    t.integer "slot_status", default: 1
    t.integer "full_status", default: 1
    t.integer "slot_purpose"
    t.integer "slot_size"
  end

  create_table "trucks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "kanji"
    t.string "up_num"
    t.string "hiragana"
    t.string "btm_left_num"
    t.string "btm_right_num"
    t.string "cntr_number"
    t.string "date"
    t.string "ordered_begin_time"
    t.string "ordered_end_time"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "allowance", default: 1
    t.index ["order_id"], name: "index_trucks_on_order_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "authority"
    t.string "driver"
    t.string "phone"
    t.string "company"
    t.string "certificate"
    t.bigint "power_id", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["power_id"], name: "index_users_on_power_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "manuals", "users"
  add_foreign_key "my_trucks", "users"
  add_foreign_key "notices", "users"
  add_foreign_key "orders", "slots"
  add_foreign_key "orders", "users"
  add_foreign_key "trucks", "orders"
  add_foreign_key "users", "powers"
end
