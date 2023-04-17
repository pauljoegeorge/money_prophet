# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_16_232221) do
  create_table "fixed_expense_categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_fixed_expense_categories_on_name", unique: true
    t.index ["uid"], name: "index_fixed_expense_categories_on_uid", unique: true
    t.index ["user_id"], name: "index_fixed_expense_categories_on_user_id"
  end

  create_table "fixed_expenses", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.date "apply_from", null: false
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fixed_expense_category_id", null: false
    t.bigint "user_id", null: false
    t.index ["fixed_expense_category_id"], name: "index_fixed_expenses_on_fixed_expense_category_id"
    t.index ["uid"], name: "index_fixed_expenses_on_uid", unique: true
    t.index ["user_id"], name: "index_fixed_expenses_on_user_id"
  end

  create_table "unexpected_expense_categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_unexpected_expense_categories_on_name", unique: true
    t.index ["uid"], name: "index_unexpected_expense_categories_on_uid", unique: true
    t.index ["user_id"], name: "index_unexpected_expense_categories_on_user_id"
  end

  create_table "unexpected_expenses", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.date "apply_in", null: false
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unexpected_expense_category_id", null: false
    t.bigint "user_id", null: false
    t.index ["uid"], name: "index_unexpected_expenses_on_uid", unique: true
    t.index ["unexpected_expense_category_id"], name: "index_unexpected_expenses_on_unexpected_expense_category_id"
    t.index ["user_id"], name: "index_unexpected_expenses_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "fixed_expense_categories", "users"
  add_foreign_key "fixed_expenses", "fixed_expense_categories"
  add_foreign_key "fixed_expenses", "users"
  add_foreign_key "unexpected_expense_categories", "users"
  add_foreign_key "unexpected_expenses", "unexpected_expense_categories"
  add_foreign_key "unexpected_expenses", "users"
end
