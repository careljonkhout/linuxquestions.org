class Question < ActiveRecord::Base
  hobo_model # Don't put anything above this

  fields do
    question :string
    timestamps
  end

  belongs_to :owner, :class_name => 'User', :creator => true
  has_many :answers, :accessible => true, :dependent => :destroy
  has_many :questions_quizzes, :dependent => :destroy
  has_many :quizzes, :through => :questions_quizzes

  never_show :owner

  validates_presence_of :question
  validate :must_have_an_answer
  validate :must_have_one_correct_answer, :if => 'answers.size >= 1'

  def must_have_an_answer
    errors.add_to_base("You must specify at least one answer.") if answers.size < 1
  end

  def must_have_one_correct_answer
    if correct_answer_count < 1
      errors.add_to_base('You mark at least one answer as "correct".')
    end
  end

  def correct_answer_count
    answers.inject(0) { |count, answer| count += answer.correct ? 1 : 0 }
  end

  def single_correct_answer?; correct_answer_count == 1 end

  def multiple_choice?; answers.count > 1 end

  def name; question end

  include ActionView::Helpers::TextHelper # to use truncate

  def to_s # This is how a question will appear in select menu's
    truncate question, :length => 120
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    owner_is? acting_user
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
end
