# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :user

  enum news_type: %i[featured]
end
