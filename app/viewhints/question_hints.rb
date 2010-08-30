class QuestionHints < Hobo::ViewHints

  children :answers

  field_help :explanation => 'If you wish, you can enter an explantion of the question here.
   It will be shown to the quiz-takers after they have completed the quiz.'

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
end
