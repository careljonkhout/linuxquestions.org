class ExamsController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index, :edit, :update]

  auto_actions_for :quiz, [:create]

end
