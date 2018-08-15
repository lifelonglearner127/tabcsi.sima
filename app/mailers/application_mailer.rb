# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Nenv.instance.mailer_sender

  layout 'mailer'

  def mailer_subject
    message.subject
  end

  helper_method :mailer_subject
end
