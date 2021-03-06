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

ActiveRecord::Schema.define(version: 20180430122410) do

  create_table "answers", force: :cascade do |t|
    t.string   "text",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "compatibility_scores", force: :cascade do |t|
    t.integer "score"
    t.integer "user_id"
    t.integer "compared_user"
    t.index ["user_id"], name: "index_compatibility_scores_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string  "venue"
    t.string  "address"
    t.string  "date"
    t.integer "groups_id"
    t.index ["groups_id"], name: "index_events_on_groups_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "chat_name"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name",             null: false
    t.integer  "questionnaire_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "is_user_ready_for_match", default: false, null: false
    t.boolean  "matched",                 default: false, null: false
    t.integer  "groups_id"
    t.integer  "compatibility_score_id"
    t.string   "mb_value"
    t.index ["compatibility_score_id"], name: "index_users_on_compatibility_score_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["groups_id"], name: "index_users_on_groups_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
