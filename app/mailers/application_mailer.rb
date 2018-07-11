# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Nenv.instance.mailer_sender

  layout 'mailer'
end
