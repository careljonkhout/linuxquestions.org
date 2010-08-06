class Answer < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    answer  :string
    correct :boolean
  end

  belongs_to :question

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    question.owner_is? acting_user
  end

  def destroy_permitted?
    question.owner_is? acting_user
  end

  def view_permitted?(field)
    true
  end

end
