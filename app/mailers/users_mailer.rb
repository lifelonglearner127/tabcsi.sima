# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  layout 'users_mailer'

  def request_pin
    @pin = params[:pin]

    mail to: params[:recipient]
  end
end
