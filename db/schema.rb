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

ActiveRecord::Schema[7.0].define(version: 2023_05_19_131133) do
  create_table "fixed_expense_categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "name", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_fixed_expense_categories_on_name_and_user_id", unique: true
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

  create_table "income_sources", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "source", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source", "user_id"], name: "index_income_sources_on_source_and_user_id", unique: true
    t.index ["uid"], name: "index_income_sources_on_uid", unique: true
    t.index ["user_id"], name: "index_income_sources_on_user_id"
  end

  create_table "incomes", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.date "apply_from", null: false
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "income_source_id", null: false
    t.bigint "user_id", null: false
    t.index ["income_source_id"], name: "index_incomes_on_income_source_id"
    t.index ["uid"], name: "index_incomes_on_uid", unique: true
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "unexpected_expense_categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "name", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_unexpected_expense_categories_on_name_and_user_id", unique: true
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
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "password_digest"
    t.string "uqid", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "fixed_expense_categories", "users"
  add_foreign_key "fixed_expenses", "fixed_expense_categories"
  add_foreign_key "fixed_expenses", "users"
  add_foreign_key "income_sources", "users"
  add_foreign_key "incomes", "income_sources"
  add_foreign_key "incomes", "users"
  add_foreign_key "unexpected_expense_categories", "users"
  add_foreign_key "unexpected_expenses", "unexpected_expense_categories"
  add_foreign_key "unexpected_expenses", "users"
end
