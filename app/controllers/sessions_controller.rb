# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_page_options, only: %i[create new]

  def new
    # TODO: redirect to dashboard if user already logged in

    self.session_email = nil
  end

  def create
    if session_params.key?(:pin)
      # TODO: validate pin
    else
      request_pin
    end
  end

  def delete; end

  private

  def set_page_options
    self.page_data_options = {
      url: log_in_path,
      method: 'post',
      local: true,
      html: {
        sign_up_path: sign_up_path,
        email: session_email
      }
    }
  end

  def session_email
    session[:email]
  end

  def session_email=(value)
    session[:email] = value
    page_data_options[:html][:email] = value
  end

  def request_pin
    self.session_email = session_params[:email]

    User.find_by(email: session_email)&.request_pin

    render 'new'
  end

  def session_params
    @session_params ||= params.require(:session).permit(:email, :pin)
  end

  def log_in(user)
    session[:user_id] = user&.id
  end
end
