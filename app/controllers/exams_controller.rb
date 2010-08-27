class ExamsController < ApplicationController

  hobo_model_controller

  auto_actions :show

  def create
    hobo_create do
      flash[:notice] = ''
      redirect_to edit_response_path(@exam.responses.first)
    end
  end

  auto_actions_for :quiz, [:create]

end
