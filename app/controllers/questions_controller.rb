# frozen_string_literal: true

class QuestionsController < ApplicationController
  def help
    @question =
      Question
      .current_questions
      .includes(:question_help_items)
      .where(question_number: params.require(:number))
      .first
  end
end
