class AddQuestionsQuizzes < ActiveRecord::Migration
  def self.up
    create_table :questions_quizzes do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    drop_table :questions_quizzes

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
