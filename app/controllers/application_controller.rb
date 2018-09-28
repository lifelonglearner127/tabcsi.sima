# frozen_string_literal: true

class ApplicationController < ActionController::Base
  attr_writer :page_data_options

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:logged_in] && current_user.present?
  end

  def page_data_options
    @page_data_options || {}
  end

  def require_logged_in_user
    return if logged_in?

    redirect_to log_in_url
  end

  helper_method :current_user
  helper_method :page_data_options
end
