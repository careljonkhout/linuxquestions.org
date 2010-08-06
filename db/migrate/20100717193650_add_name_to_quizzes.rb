class AddNameToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :name, :string

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    remove_column :quizzes, :name

    add_index :questions, [:owner_id], :name => 'index_questions_on_user_id'
  end
end
