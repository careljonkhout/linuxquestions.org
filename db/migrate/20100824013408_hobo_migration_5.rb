class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :questions, :explanation, :string

    remove_column :answers, :explanation

    remove_index :responses, :name => :index_answered_questions_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_exam_id rescue ActiveRecord::StatementInvalid

    remove_index :quizzes, :name => :index_quizzes_on_user_id rescue ActiveRecord::StatementInvalid

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid

    remove_index :exams, :name => :index_exams_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :questions, :explanation

    add_column :answers, :explanation, :text

    add_index :responses, [:question_id], :name => 'index_answered_questions_on_question_id'
    add_index :responses, [:exam_id], :name => 'index_answered_questions_on_exam_id'

    add_index :quizzes, [:owner_id], :name => 'index_quizzes_on_user_id'

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'

    add_index :exams, [:owner_id], :name => 'index_exams_on_user_id'
  end
end
