class QuestionsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  auto_actions_for :answers, [:new, :create]

  def rate
    @question = Question.find(params[:id])
    @question.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @question.wrapper_dom_id(params), ratings_for(@question, params.merge(:wrap => false))
      page.visual_effect :highlight, @question.wrapper_dom_id(params)
    end
  end
  
end
