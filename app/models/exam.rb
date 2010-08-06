class Exam < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    current_question_index :integer, :default => 0
  end

  never_show(:current_question_index, :user)

  belongs_to :quiz
  belongs_to :user, :creator => true
  has_many :responses, :dependent => :destroy

  def current_question; quiz.questions[current_question_index] end

  def response_created
    self.current_question_index += 1
    save false
  end

  def finished?; current_question == nil; end

  def score
    points = responses.inject(0) { |points, response| points += response.correct? ? 1 : 0 }
    (points.to_f / responses.size * 100).round
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
