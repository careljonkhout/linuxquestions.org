class Question < ActiveRecord::Base
  hobo_model # Don't put anything above this

  fields do
    question :string, :required, :name => true
    timestamps
    rating_average :decimal, :default => 0, :precision => 6, :scale => 2
    explanation :string
  end

  ajaxful_rateable # defaults are: :stars => 5, :allow_update => true, :cache_column => :rating_average

  belongs_to :owner, :class_name => 'User', :creator => true
  has_many :answers, :accessible => true, :dependent => :destroy
  has_many :questions_quizzes, :dependent => :destroy
  has_many :quizzes, :through => :questions_quizzes

  never_show :owner, :rating_average

  validate :must_have_one_correct_answer

  def must_have_one_correct_answer
    if correct_answer_count < 1
      errors.add_to_base('You must mark at least one answer as "correct".')
    end
  end

  def correct_answers
    answers.select { |answer| answer.correct }
  end

  def correct_answer_count; correct_answers.size end
  def single_correct_answer?; correct_answer_count == 1 end
  def multiple_choice?; answers.count > 1 end

  include ActionView::Helpers::TextHelper # to use truncate

  def to_s # This is how a question will appear in select menu's
    truncate question, :length => 120
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    owner_is?(acting_user) || acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
end
