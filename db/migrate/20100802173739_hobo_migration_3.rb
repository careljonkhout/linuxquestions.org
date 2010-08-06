class HoboMigration3 < ActiveRecord::Migration
  def self.up
    create_table :answers_responses do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :answer_id
      t.integer  :response_id
    end
    add_index :answers_responses, [:answer_id]
    add_index :answers_responses, [:response_id]

    remove_index :responses, :name => :index_answered_questions_on_answer_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_exam_id rescue ActiveRecord::StatementInvalid

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :answers_responses

    add_index :responses, [:answer_id], :name => 'index_answered_questions_on_answer_id'
    add_index :responses, [:question_id], :name => 'index_answered_questions_on_question_id'
    add_index :responses, [:exam_id], :name => 'index_answered_questions_on_exam_id'

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
