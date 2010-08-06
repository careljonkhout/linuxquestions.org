class CreateQuizzesExamsAndAnsweredQuestions < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :exams do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :quiz_id
      t.integer  :user_id
    end
    add_index :exams, [:quiz_id]
    add_index :exams, [:user_id]

    create_table :answered_questions do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :text_answer
      t.integer  :exam_id
      t.integer  :question_id
      t.integer  :answer_id
    end
    add_index :answered_questions, [:exam_id]
    add_index :answered_questions, [:question_id]
    add_index :answered_questions, [:answer_id]

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :quizzes
    drop_table :exams
    drop_table :answered_questions

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
