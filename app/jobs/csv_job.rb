# frozen_string_literal: true

require 'csv'
require 'fileutils'
class CsvJob < ApplicationJob
  queue_as :default

  COLUMN_HEADERS = %i[
    full_name email phone job_title
  ].freeze

  REQUIRED_COLUMNS = %i[
    full_name email job_title
  ].freeze

  def perform(file, current_user)
    row_number = 0

    CSV.foreach(
      file,
      headers: COLUMN_HEADERS,
      return_headers: false,
      skip_blanks: true
    ) do |row|
      if row.fields.compact.empty? ||
         !row.to_hash.fetch_values(*REQUIRED_COLUMNS).all?
        next
      end

      user = User.new(row.to_hash)
      user.imported = true
      row_number += 1

      if user.valid?
        user.save
      else
        message = {
          type: 'error',
          body: "Line #{row_number}: #{user.errors.full_messages.join(', ')}"
        }
        CsvChannel.broadcast_to(current_user, message)
        return false
      end
    end
    message = {
      type: 'completed',
      body: 'Users imported successfully.'
    }
    CsvChannel.broadcast_to(current_user, message)

    FileUtils.rm file
  end
end
