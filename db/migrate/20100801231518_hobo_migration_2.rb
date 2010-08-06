class HoboMigration2 < ActiveRecord::Migration
  def self.up
    change_column :exams, :current_question_index, :integer, :default => 0

    remove_index :responses, :name => :index_answered_questions_on_answer_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :responses, :name => :index_answered_questions_on_exam_id rescue ActiveRecord::StatementInvalid

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    change_column :exams, :current_question_index, :integer

    add_index :responses, [:answer_id], :name => 'index_answered_questions_on_answer_id'
    add_index :responses, [:question_id], :name => 'index_answered_questions_on_question_id'
    add_index :responses, [:exam_id], :name => 'index_answered_questions_on_exam_id'

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
