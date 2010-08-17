class Quiz < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
    rating_average :decimal, :default => 0, :precision => 6, :scale => 2
  end

  ajaxful_rateable # defaults are: :stars => 5, :allow_update => true, :cache_column => :rating_average

  belongs_to :owner, :class_name => 'User', :creator => true

  has_many :questions_quizzes, :dependent => :destroy
  has_many :questions, :through => :questions_quizzes, :accessible => true

  has_many :exams

  never_show :owner
  never_show :rating_average

  before_save do |r|
    if r.name.empty?
      r.name = "#{(r.owner.quizzes.size+1).ordinalize} Quiz by #{r.owner}"
    end
  end

  # --- Permissions --- #

  def empty?; false end

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
