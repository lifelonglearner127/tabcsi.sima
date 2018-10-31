# frozen_string_literal: true

class NewsJob < ApplicationJob
  queue_as :default

  def perform(message)
    android_tokens = PushToken.where(device_type: :android).pluck(:token)
    ios_tokens = PushToken.where(device_type: :ios).pluck(:token)

    begin
      TabcSi::PushManager.send(android_tokens, ios_tokens, message)
    rescue StandardError => error
      Rails.logger.error(error)
    end
  end
end
