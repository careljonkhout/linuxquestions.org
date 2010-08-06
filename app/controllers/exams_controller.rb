class ExamsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index, :new, :create, :edit, :update]

  def create
    hobo_create do
      flash[:notice] = ''
      redirect_to new_response_for_exam_path(@exam)
    end
  end

  auto_actions_for :quiz, [:create]

end
