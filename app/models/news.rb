# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user, -> { with_discarded }, optional: true

  enum news_type: %i[featured]

  after_commit(
    :send_push_notifications,
    on: :create,
    if: -> { Rails.env.production? }
  )

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end

  private

  def send_push_notifications
    message = {
      id: id,
      subject: subject.truncate(40),
      created_at: created_at,
      link: link
    }

    android_tokens = PushToken.where(device_type: :android).pluck(:token)
    ios_tokens = PushToken.where(device_type: :ios).pluck(:token)

    begin
      TabcSi::PushManager.send(android_tokens, ios_tokens, message)
    rescue StandardError => error
      Rails.logger.error(error)
    end
  end
end
