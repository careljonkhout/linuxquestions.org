class AddUserIdToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :user_id, :integer

    add_index :questions, [:user_id]
  end

  def self.down
    remove_column :questions, :user_id

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
