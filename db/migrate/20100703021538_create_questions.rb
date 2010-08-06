class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string  :answer
      t.boolean :correct
      t.integer :question_id
    end
    add_index :answers, [:question_id]
  end

  def self.down
    drop_table :answers
  end
end
