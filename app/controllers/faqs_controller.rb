# frozen_string_literal: true

class FaqsController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options

  def index
    @questions = Question.current_questions.includes(:question_help_items)
    @hide_site_version = true
  end
end
