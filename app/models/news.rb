# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to(
    :created_by,
    -> { with_discarded },
    class_name: 'User',
    foreign_key: 'user_id',
    optional: true
  )

  enum news_type: %i[featured]

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end
end
