class ResponsesController < ApplicationController

  hobo_model_controller


  auto_actions_for :exam, :new

  def create
    hobo_create do
      @exam = @response.exam
      flash[:notice] = ''
      unless @exam.finished?
        if valid?
          redirect_to new_response_for_exam_path(@response.exam)
        else
          render :action => 'new_for_exam'
        end
      else
        redirect_to @exam
      end
    end
  end
end
