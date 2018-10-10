# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :inspection
  has_many_attached :pictures
  belongs_to :question

  validates :question, uniqueness: { scope: :inspection }

  def photos
    pictures.map do |pic|
      blob = pic.blob

      {
        url: Rails.application.routes.url_helpers.rails_blob_url(pic),
        content_type: blob.content_type,
        checksum: blob.checksum
      }
    end
  end
end
