# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user, -> { with_discarded }, optional: true

  enum news_type: %i[featured]

  def link
    Rails.application.routes.url_helpers.news_url(id: id)
  end
end
