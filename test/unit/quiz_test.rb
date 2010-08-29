require File.dirname(__FILE__) + '/../test_helper'

class QuizTest < ActiveSupport::TestCase

  def test_must_produce_error_when_doesnt_have_at_least_one_question
    q = Quiz.new
    q.valid? # because of a rails 2.3.8 bug this is necessary
    assert q.errors.full_messages.include?("You must select at least one question.")
  end
  
end
