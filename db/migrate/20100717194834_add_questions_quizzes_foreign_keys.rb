class AddQuestionsQuizzesForeignKeys < ActiveRecord::Migration
  def self.up
    add_column :questions_quizzes, :question_id, :integer
    add_column :questions_quizzes, :quiz_id, :integer
  end

  def self.down
    raise Exception.new 'migration is not reversible.'
  end
end
