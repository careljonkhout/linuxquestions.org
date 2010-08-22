class QuizzesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :show

  auto_actions_for :owner, :index

  def show
    hobo_show do
      unless current_user.signed_up?
        flash[:notice] = 'Please sign up to take a quiz.'
        redirect_to user_signup_path
      end
    end
  end

  def rate
    @quiz = Quiz.find(params[:id])
    @quiz.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html 'average_rating', ratings_for(@quiz)
      page.replace_html 'user_rating', ratings_for(@quiz, :show_user_rating => true)
      page.visual_effect :highlight, 'average_rating'
      page.visual_effect :highlight, 'user_rating'
    end
  end
end
