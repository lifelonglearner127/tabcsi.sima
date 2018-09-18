# frozen_string_literal: true

class FaqsController < ApplicationController
  def index
    @questions = Question.current_questions.includes(:question_help_items)
  end
end
