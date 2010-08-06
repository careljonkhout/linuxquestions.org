class RenameAnsweredQuestions < ActiveRecord::Migration
  def self.up
    rename_table :answered_questions, :responses
  end

  def self.down
    rename_table :responses, :answered_questions
  end
end