class Exam < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    session_id :string
  end

  never_show :session_id

  belongs_to :quiz
  belongs_to :owner, :class_name => "User", :creator => true
  has_many :responses, :dependent => :destroy

  attr_protected :responses

  after_create do |exam|
    exam.quiz.questions.each do |question|
      r = exam.responses.create(:question => question, :exam => exam)
      r.save false
    end
  end

  def previous_response(current_response); responses[responses.index(current_response)-1] end
  def next_response(current_response); responses[responses.index(current_response)+1] end


  def score
    points = responses.inject(0) { |points, response| points += response.correct? ? 1 : 0 }
    (points.to_f / responses.size * 100).round
  end
  # --- Permissions --- #
  
  def create_permitted?
    true
  end

  def update_permitted?
    false
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
