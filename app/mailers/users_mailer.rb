# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  layout 'users_mailer'

  def request_pin
    @pin = params[:pin]

    mail to: params[:recipient]
  end

  def welcome
    @recipient = params[:recipient]
    @full_name = params[:full_name]
    @company_name = params[:company_name]

    mail to: @recipient
  end
end
