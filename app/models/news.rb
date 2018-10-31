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

    NewsJob.perform_later(message)
  end
end
