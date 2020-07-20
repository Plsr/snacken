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

ActiveRecord::Schema.define(version: 2020_07_19_103824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
  end

  create_table "meal_plans", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_meals"
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "meal_plans_recipes", force: :cascade do |t|
    t.bigint "meal_plan_id"
    t.bigint "recipe_id"
    t.index ["meal_plan_id"], name: "index_meal_plans_recipes_on_meal_plan_id"
    t.index ["recipe_id"], name: "index_meal_plans_recipes_on_recipe_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "unit"
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "users"
end
