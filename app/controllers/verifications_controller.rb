# frozen_string_literal: true

class VerificationsController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options

  layout false

  def show
    @pin = params[:pin]
  end
end
