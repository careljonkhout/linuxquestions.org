class ResponsesController < ApplicationController

  hobo_model_controller

  def edit
    @response = Response.find params[:id]
    @exam = @response.exam
    unless current_user == @exam.owner || !current_user.signed_up? && @exam.session_id == session[:session_id]
      raise Exception.new 'Unauthorized Request'
    end
  end

  def update
    @response = Response.find params[:id]
    @exam = @response.exam
    if current_user == @exam.owner || !current_user.signed_up? && @exam.session_id == session[:session_id]
      if @response.update_attributes params[:response]
        unless @response.last?
          redirect_to edit_response_path(@response._next)
        else
          redirect_to @exam
        end
      else
        render :action => 'edit'
      end
    else
      raise Exception.new 'Unauthorized Request'
    end
  end
end
