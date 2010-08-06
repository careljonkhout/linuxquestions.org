class Rating < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    stars :integer
    timestamps
  end

  belongs_to :user, :creator => true
  belongs_to :question

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_in?
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
