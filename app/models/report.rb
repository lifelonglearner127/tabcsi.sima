# frozen_string_literal: true

class Report < ApplicationRecord
  has_one_attached :file
  belongs_to :user

  validates :fiscal_year, presence: true

  after_create :start_generating

  def to_hash
    {
      generated_by: user.full_name,
      fiscal_year: fiscal_year,
      include_received: include_received,
      updated_at: updated_at,
      download_path: download_path
    }
  end

  private

  def download_path
    return nil unless file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(
      file,
      disposition: :attachment
    )
  end

  def start_generating
    ReportsJob.perform_later(self)
  end
end
