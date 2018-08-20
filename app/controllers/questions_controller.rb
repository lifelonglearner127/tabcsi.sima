# frozen_string_literal: true

class QuestionsController < ApplicationController
  def help
    @question_number = params.require(:number)
  end
end
