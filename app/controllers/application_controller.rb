# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_logged_in_user
  before_action :set_page_options

  helper_method :current_user, :page_data_options, :site_version

  protected

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

  def reset_page_options(page_options = {})
    self.page_data_options = default_page_options.deep_merge(page_options)
  end

  private

  def default_page_options
    {}
  end

  def set_page_options
    if respond_to?(:controller_page_options, true)
      reset_page_options(controller_page_options)
    else
      reset_page_options
    end
  end
end
