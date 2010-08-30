class ExamsController < ApplicationController

  hobo_model_controller

  auto_actions :show

  def update
    @exam = Exam.find params[:id]
    if current_user == @exam.owner || !current_user.signed_up? && @exam.session_id == session[:session_id]
      @exam.update_attributes params[:exam]
      render :results
    end
  end

  def show
    hobo_show do
      if @exam.finished
        render 'results'
      else
        render 'review'
      end
    end
  end

  def create
    @exam = Exam.new(params[:exam])
    if current_user.signed_up?
      @exam.owner = current_user
    else
      @exam.session_id = session[:session_id]
    end
    hobo_create @exam do
      flash[:notice] = ''
      redirect_to edit_response_path(@exam.responses.first)
    end
  end

  auto_actions_for :quiz, [:create]

end
