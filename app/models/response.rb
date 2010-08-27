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

  def text_answer_present?; text_answer && !text_answer.empty? end

  def first?; @exam.responses[0] == self end
  def last?; @exam.responses[-1] == self end

  def previous; @exam.previous_response(self) end
  def _next; @exam.next_response(self) end

  def correct?
    if question.multiple_choice?
      question.answers.select{|a| a.correct?} == answers
    else
      text_answer == question.answers[0].answer
    end
  end

  def show_answers
    if question.multiple_choice?
      string = answers.inject('') { |str, a| str.concat a.answer + ', ' }
      string[0..-3]
    else
      text_answer
    end
  end

  def answers_label
    if answers.size == 0 && !text_answer
      'You did not give any answers.'
    elsif answers.size == 1 || text_answer
      'Your answer was:'
    else
      'Your answers were:'
    end
  end

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
