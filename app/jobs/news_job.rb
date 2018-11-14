# frozen_string_literal: true

class NewsJob < ApplicationJob
  queue_as :news

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

    # the joins excludes discarded users
    tokens = PushToken.joins(:user).where(
      id: PushToken.group(:user_id, :device_type).maximum(:id).values
    )

    android_tokens = tokens.select(&:android?).map(&:token).uniq
    ios_tokens = tokens.select(&:ios?).map(&:token).uniq

    begin
      TabcSi::PushManager.send(android_tokens, ios_tokens, message)
    rescue StandardError => error
      logger.error(error)
    end
  end
end
