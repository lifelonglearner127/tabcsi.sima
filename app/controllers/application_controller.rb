# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :page_data_options, :site_version

  protected

  attr_writer :page_data_options

  def current_user
    return @current_user if @current_user.present?

    user_id = session[:user_id]
    return nil if user_id.blank?

    @current_user = User.find_by(id: user_id)
  end

  def logged_in?
    session[:logged_in] && current_user.present?
  end

  def page_data_options
    @page_data_options || {}
  end

  def require_logged_in_user(*roles)
    roles = User.roles.keys if roles.blank? # set default
    roles = roles.map(&:to_sym) # we want symbols

    return if logged_in? && roles.include?(current_user.role.to_sym)

    redirect_to log_in_url
  end

  def reset_page_options(page_options = {})
    self.page_data_options = default_page_options.deep_merge(page_options)
  end

  def set_page_options
    if respond_to?(:controller_page_options, true)
      reset_page_options(controller_page_options)
    else
      reset_page_options
    end
  end

  private

  def default_page_options
    {}
  end

  def site_version
    version = "v#{TabcSi::VERSION}"

    version += ' (dev)' if Rails.env.development?
    version += ' (test)' if Rails.env.test?
    version += ' (sandbox)' if Rails.env.production? && Nenv.instance.app_debug?

    version
  end
end
