class QuizzesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :show

  def show
    hobo_show do
      unless current_user.signed_up?
        flash[:notice] = 'Please sign up to take a quiz.'
        redirect_to user_signup_path
      end
    end
  end
end
