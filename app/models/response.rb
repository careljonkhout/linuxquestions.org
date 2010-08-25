class Response < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    text_answer :string
  end

  belongs_to :exam
  belongs_to :question
  has_many :answers_response
  has_many :answers, :through => :answers_response

  validate :presence_of_answer

  def presence_of_answer
    unless text_answer_present? || !answers.empty?
      errors.add_to_base 'You did not give an answer to the question.'
    end
  end

  def text_answer_present?; text_answer != nil && !text_answer.empty? end

  def after_initialize; self.question = exam.current_question if question.nil? && new_record? end

  after_create { |r| r.exam.response_created }

  def correct?
    if question.multiple_choice?
      answers.all? { |answer| answer.correct? }
    else
      text_answer == question.answers[0].answer
    end
  end

  def show_answers
    if question.multiple_choice?
      answers.inject('') { |str, a| str.concat a.answer + ' ' }
    else
      text_answer
    end
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? && !exam.finished?
  end

  def update_permitted?
    exam.owner_is? acting_user
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    exam.owner_is? acting_user
  end

end
