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

ActiveRecord::Schema.define(version: 20180309121547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completed_trainings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "training_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_completed_trainings_on_training_id"
    t.index ["user_id", "training_id"], name: "index_completed_trainings_on_user_id_and_training_id", unique: true
    t.index ["user_id"], name: "index_completed_trainings_on_user_id"
  end

  create_table "training_plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_training_plans_on_name", unique: true
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "start_time", null: false
    t.bigint "training_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_trainings_on_training_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", default: "", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.integer "age"
    t.bigint "training_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_users_on_training_plan_id"
  end

  add_foreign_key "completed_trainings", "trainings"
  add_foreign_key "completed_trainings", "users"
  add_foreign_key "trainings", "training_plans"
  add_foreign_key "users", "training_plans"
end
