# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  def request_pin
    @pin = params[:pin]

    mail to: params[:recipient]
  end
end
