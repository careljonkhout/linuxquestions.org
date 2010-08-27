class AnswersResponse < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :answer
  belongs_to :response

  # --- Permissions --- #

  def create_permitted?
    response.update_permitted?
  end

  def update_permitted?
    response.update_permitted?
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    true
  end

end
