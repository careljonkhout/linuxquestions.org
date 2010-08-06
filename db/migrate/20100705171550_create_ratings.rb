class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer  :stars
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :question_id
    end
    add_index :ratings, [:user_id]
    add_index :ratings, [:question_id]
  end

  def self.down
    drop_table :ratings
  end
end
