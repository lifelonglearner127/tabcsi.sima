# frozen_string_literal: true

class FaqsController < ApplicationController
  def index
    @questions = Question.current_questions.includes(:question_help_items)
  end

  def parse_item(item)
    Kramdown::Document.new(item.value).to_html
  end

  helper_method :parse_item
end
