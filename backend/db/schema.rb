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

ActiveRecord::Schema.define(version: 2021_01_31_232910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows_relationships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_follows_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_follows_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_follows_relationships_on_user_id"
  end

  create_table "likes_relationships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_likes_relationships_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_relationships_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_relationships_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "screen_name", null: false
    t.string "password_digest", null: false
    t.boolean "activated", default: false, null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "biography", default: "", null: false
  end

  add_foreign_key "follows_relationships", "users"
  add_foreign_key "follows_relationships", "users", column: "follow_id"
  add_foreign_key "likes_relationships", "posts"
  add_foreign_key "likes_relationships", "users"
  add_foreign_key "posts", "users", column: "author_id"
end
