# frozen_string_literal: true

class NewsJob < ApplicationJob
  queue_as :default

  def perform(news)
    message = {
      id: news.id,
      subject: news.subject.truncate(40),
      created_at: news.created_at,
      link: news.link
    }

    unless Rails.env.production?
      logger.debug(message)

      return
    end

    android_tokens = PushToken.where(device_type: :android).pluck(:token)
    ios_tokens = PushToken.where(device_type: :ios).pluck(:token)

    begin
      TabcSi::PushManager.send(android_tokens, ios_tokens, message)
    rescue StandardError => error
      logger.error(error)
    end
  end
end
