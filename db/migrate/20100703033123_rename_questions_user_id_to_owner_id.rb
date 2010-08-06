class RenameQuestionsUserIdToOwnerId < ActiveRecord::Migration
  def self.up
    rename_column :questions, :user_id, :owner_id

    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
    add_index :questions, [:owner_id]
  end

  def self.down
    rename_column :questions, :owner_id, :user_id

    remove_index :questions, :name => :index_questions_on_owner_id rescue ActiveRecord::StatementInvalid
    add_index :questions, [:user_id]
  end
end
