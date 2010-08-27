# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def response_answers_label response
    if response.answers.size == 0 && !response.text_answer
      'You did not give any answers.'
    elsif response.answers.size == 1 || response.text_answer
      'Your answer was:'
    else
      'Your answers were:'
    end
  end
end