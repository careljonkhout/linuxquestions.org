class QuestionsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  auto_actions_for :answers, [:new, :create]

  auto_actions_for :owner, :index

  def rate
    @question = Question.find(params[:id])
    @question.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html 'average_rating', ratings_for(@question)
      page.replace_html 'user_rating', ratings_for(@question, :show_user_rating => true)
      page.visual_effect :highlight, 'average_rating'
      page.visual_effect :highlight, 'user_rating'
    end
  end
  
end
