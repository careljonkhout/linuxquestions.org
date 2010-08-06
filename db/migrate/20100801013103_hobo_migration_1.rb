class HoboMigration1 < ActiveRecord::Migration
  def self.up
    add_column :exams, :current_question_index, :integer

    remove_index :responses, :name => :index_answered_questions_on_answer_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_exam_id rescue ActiveRecord::StatementInvalid
    add_index :responses, [:exam_id]
    add_index :responses, [:question_id]
    add_index :responses, [:answer_id]

    add_index :questions_quizzes, [:question_id]
    add_index :questions_quizzes, [:quiz_id]

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :exams, :current_question_index

    remove_index :responses, :name => :index_responses_on_exam_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_responses_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_responses_on_answer_id rescue ActiveRecord::StatementInvalid
    add_index :responses, [:answer_id], :name => 'index_answered_questions_on_answer_id'
    add_index :responses, [:question_id], :name => 'index_answered_questions_on_question_id'
    add_index :responses, [:exam_id], :name => 'index_answered_questions_on_exam_id'

    remove_index :questions_quizzes, :name => :index_questions_quizzes_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :questions_quizzes, :name => :index_questions_quizzes_on_quiz_id rescue ActiveRecord::StatementInvalid

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
