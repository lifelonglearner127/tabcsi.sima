# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user, -> { with_discarded }, optional: true

  enum news_type: %i[featured]

  after_create :send_push_notifications

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end

  private

  def send_push_notifications
    android_tokens = PushToken.where(device_type: :android).pluck(:token)
    ios_tokens = PushToken.where(device_type: :ios).pluck(:token)

    message = {
      id: id,
      subject: subject.truncate(40),
      created_at: created_at,
      link: link
    }

    TabcSi::PushManager.send(android_tokens, ios_tokens, message)
  end
end
