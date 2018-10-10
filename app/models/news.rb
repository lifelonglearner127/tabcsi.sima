# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user

  enum news_type: %i[featured]

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end
end
