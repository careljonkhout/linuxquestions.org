class Quiz < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end

  belongs_to :owner, :class_name => 'User', :creator => true

  has_many :questions_quizzes, :dependent => :destroy
  has_many :questions, :through => :questions_quizzes, :accessible => true

  has_many :exams

  never_show :owner

  before_save { |r| r.name = "#{(r.owner.quizzes.size+1).ordinalize} Quiz by #{r.owner}" if r.name.empty? }

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    owner_is? acting_user || acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end