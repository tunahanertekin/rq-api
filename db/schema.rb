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

ActiveRecord::Schema.define(version: 2020_05_07_143812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "title"
    t.text "author"
    t.text "publisher"
    t.text "translator"
    t.integer "edition"
    t.text "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.text "title"
    t.text "body"
    t.text "owner"
    t.integer "favnum"
    t.integer "page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_quotes_on_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.text "email"
    t.text "favouriteUsers"
    t.text "favouriteBooks"
    t.text "favouriteQuotes"
    t.string "avatar"
    t.text "pinned"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "hashedPassword"
    t.text "lastLogin"
  end

  add_foreign_key "books", "users"
  add_foreign_key "quotes", "books"
end
