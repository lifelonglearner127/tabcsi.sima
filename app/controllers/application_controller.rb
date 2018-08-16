# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :set_paper_trail_whodunnit

  attr_writer :page_data_options

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def logged_in?
    session[:logged_in] && current_user.present?
  end

  def page_data_options
    @page_data_options || {}
  end

  helper_method :page_data_options

  def require_logged_in_user
    return if logged_in?

    redirect_to log_in_url
  end
end
