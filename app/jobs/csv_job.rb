# frozen_string_literal: true

require 'csv'
require 'fileutils'

class CsvJob < ApplicationJob
  queue_as :default

  COLUMN_HEADERS = %i[full_name email phone job_title].freeze
  REQUIRED_COLUMNS = %i[full_name email job_title].freeze

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

      row = row.to_hash
      user = User.find_by(email: row[:email])
      next if user.present? # skip existing users

      user = User.new(row)
      user.imported = true
      row_number += 1

      unless user.valid?
        CsvChannel.broadcast_to(
          current_user,
          type: 'error',
          body: "Line #{row_number}: #{user.errors.full_messages.join(', ')}"
        )

        return false
      end

      user.save
    end

    CsvChannel.broadcast_to(
      current_user,
      type: 'completed',
      body: 'Users imported successfully.'
    )

    FileUtils.rm(file)
  end
end
