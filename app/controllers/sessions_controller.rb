# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_logged_in_user, only: %i[destroy]
  before_action :set_page_options, only: %i[create new]

  def create
    if pin_requested?
      validate_pin
    else
      request_pin
    end
  end

  def destroy
    log_out if pin_requested? || logged_in?

    redirect_to root_url
  end

  def new
    redirect_to(dashboard_url) && return if logged_in?

    log_out unless pin_requested?
  end

  def resend_pin
    if pin_requested? && current_user.present?
      current_user.request_pin(web: true)
    end

    redirect_to log_in_url
  end

  private

  def controller_page_options
    {
      url: log_in_path,
      method: 'post',
      local: true,
      html: {
        email: session_email,
        pin_requested: pin_requested?,
        pin_length: Setting.pin_length,
        flash_message: flash[:notice]
      }
    }
  end

  def log_out
    reset_session
  end

  def pin_requested=(value)
    session[:pin_requested] = value
    page_data_options[:html][:pin_requested] = value
  end

  def pin_requested?
    session[:pin_requested]
  end

  def request_pin
    self.session_email = session_params[:email]

    user = User.find_for_database_authentication(email: session_email)
    if user.present? && user.request_pin(web: true)
      session[:user_id] = user.id
      self.session_email = nil
    else
      Rails.logger.error('Email address does not exist.')
    end

    self.pin_requested = true

    render 'new'
  end

  def session_email
    session[:email] || current_user&.email
  end

  def session_email=(value)
    session[:email] = value
    page_data_options[:html][:email] = value || current_user&.email
  end

  def session_params
    @session_params ||= params.require(:session).permit(:email, :pin)
  end

  def validate_pin
    pin = session_params[:pin]&.strip

    if pin.present? && current_user.valid_pin?(pin)
      self.pin_requested = false
      session[:logged_in] = true

      redirect_to dashboard_url

      return
    end

    page_data_options[:html][:errors] = {
      pin: 'Login Error: Incorrect PIN.'
    }

    render 'new'
  end
end
