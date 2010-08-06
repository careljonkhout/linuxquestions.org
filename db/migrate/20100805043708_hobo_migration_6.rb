class HoboMigration6 < ActiveRecord::Migration
  def self.up
    rename_column :quizzes, :user_id, :owner_id

    remove_index :responses, :name => :index_answered_questions_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_exam_id rescue ActiveRecord::StatementInvalid

    remove_index :quizzes, :name => :index_quizzes_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :quizzes, [:owner_id]

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    rename_column :quizzes, :owner_id, :user_id

    add_index :responses, [:question_id], :name => 'index_answered_questions_on_question_id'
    add_index :responses, [:exam_id], :name => 'index_answered_questions_on_exam_id'

    remove_index :quizzes, :name => :index_quizzes_on_owner_id rescue ActiveRecord::StatementInvalid
    add_index :quizzes, [:user_id]

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
