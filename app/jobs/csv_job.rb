# frozen_string_literal: true

require 'csv'
require 'fileutils'

class CsvJob < ApplicationJob
  queue_as :default

  COLUMN_HEADERS = %i[full_name email phone job_title].freeze
  REQUIRED_COLUMNS = %i[full_name email job_title].freeze

  def perform(current_user, csv_path)
    row_number = 0

    User.transaction do
      CSV.foreach(
        csv_path,
        headers: COLUMN_HEADERS,
        return_headers: false,
        skip_blanks: true
      ) do |row|
        row_number += 1

        if row.fields.compact.empty? ||
           !row.to_hash.fetch_values(*REQUIRED_COLUMNS).all?
          next
        end

        row = row.to_hash

        # Check if email already exists
        user = User.find_by(email: row[:email])
        if user.present?
          CsvChannel.broadcast_to(
            current_user,
            type: 'error',
            body: "Line #{row_number}: #{user.email} already exists"
          )

          raise ActiveRecord::Rollback
        end

        user = User.new(row)
        user.imported = true
        user.company_id = current_user.company_id

        unless user.valid?
          CsvChannel.broadcast_to(
            current_user,
            type: 'error',
            body: "Line #{row_number}: #{user.errors.full_messages.join(', ')}"
          )

          raise ActiveRecord::Rollback
        end

        user.save
      end

      CsvChannel.broadcast_to(
        current_user,
        type: 'completed',
        body: 'Users imported successfully.'
      )
    end
  ensure
    FileUtils.rm(file)
  end
end
