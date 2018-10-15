# frozen_string_literal: true

class QuestionsController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options

  def help
    @question =
      Question
      .current_questions
      .includes(:question_help_items)
      .where(question_number: params.require(:number))
      .first

    @hide_site_version = true
  end
end
