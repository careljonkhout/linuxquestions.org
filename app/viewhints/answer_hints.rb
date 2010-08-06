class AnswerHints < Hobo::ViewHints

  # model_name "My Model"
  # field_names :field1 => "First Field", :field2 => "Second Field"
  field_names :correct => 'Right Answer?'
  field_help :correct => 'Check this box if this answer is correct.'
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
end
