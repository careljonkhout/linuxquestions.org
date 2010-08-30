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

ActiveRecord::Schema.define(:version => 20100829062840) do

  create_table "answers", :force => true do |t|
    t.string  "answer"
    t.boolean "correct"
    t.integer "question_id"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "answers_responses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answer_id"
    t.integer  "response_id"
  end

  add_index "answers_responses", ["answer_id"], :name => "index_answers_responses_on_answer_id"
  add_index "answers_responses", ["response_id"], :name => "index_answers_responses_on_response_id"

  create_table "exams", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quiz_id"
    t.integer  "owner_id"
    t.string   "session_id"
    t.boolean  "finished"
  end

  add_index "exams", ["owner_id"], :name => "index_exams_on_owner_id"
  add_index "exams", ["owner_id"], :name => "index_exams_on_user_id"
  add_index "exams", ["quiz_id"], :name => "index_exams_on_quiz_id"

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.decimal  "rating_average", :default => 0.0
    t.text     "explanation"
  end

  add_index "questions", ["owner_id"], :name => "index_questions_on_owner_id"
  add_index "questions", ["owner_id"], :name => "index_questions_on_user_id"

  create_table "questions_quizzes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "quiz_id"
  end

  add_index "questions_quizzes", ["question_id"], :name => "index_questions_quizzes_on_question_id"
  add_index "questions_quizzes", ["quiz_id"], :name => "index_questions_quizzes_on_quiz_id"

  create_table "quizzes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "owner_id"
    t.decimal  "rating_average", :precision => 6, :scale => 2, :default => 0.0
  end

  add_index "quizzes", ["owner_id"], :name => "index_quizzes_on_owner_id"
  add_index "quizzes", ["owner_id"], :name => "index_quizzes_on_user_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "responses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_answer"
    t.integer  "exam_id"
    t.integer  "question_id"
  end

  add_index "responses", ["exam_id"], :name => "index_answered_questions_on_exam_id"
  add_index "responses", ["exam_id"], :name => "index_responses_on_exam_id"
  add_index "responses", ["question_id"], :name => "index_answered_questions_on_question_id"
  add_index "responses", ["question_id"], :name => "index_responses_on_question_id"

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

end
