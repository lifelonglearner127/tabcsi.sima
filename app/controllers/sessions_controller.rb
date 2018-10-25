# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options, except: %i[create new]

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
    current_user.request_pin(web: true) if pin_requested?

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
    current_user.present? && session[:pin_requested]
  end

  def request_pin
    self.session_email = session_params[:email]

    user = User.find_for_database_authentication(email: session_email)
    if user.present? && user.request_pin(web: true)
      self.session_email = nil
      session[:user_id] = user.id
      self.pin_requested = true
    else
      page_data_options[:html][:errors] = {
        email: 'Login Error: Email is not registered.'
      }
    end

    render 'new'
  end

  def session_email
    session[:email]
  end

  def session_email=(value)
    session[:email] = value
    page_data_options[:html][:email] = value
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
