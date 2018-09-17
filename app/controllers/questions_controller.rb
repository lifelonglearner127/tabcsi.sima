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

  def parse_item(item)
    Kramdown::Document.new(item.value).to_html
  end

  helper_method :parse_item
end
