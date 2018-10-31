# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user, -> { with_discarded }, optional: true

  enum news_type: %i[featured]

  after_commit :send_push_notifications, on: :create

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end

  private

  def send_push_notifications
    NewsJob.perform_later(self)
  end
end
