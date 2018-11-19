# frozen_string_literal: true

require 'csv'
require 'fileutils'

class ImportsJob < ApplicationJob
  queue_as :imports

  HEADERS = %i[full_name email phone job_title location_clps].freeze
  REQUIRED_FIELDS = %i[full_name email job_title].freeze

  def perform(current_user, path)
    row_number = 0

    ActionLog.create!(
      sequence_id: sequence_id,
      tag: 'csv_job',
      message: "#{file_name(path)}: Import started."
    )

    User.transaction do
      CSV.foreach(
        path,
        headers: HEADERS,
        return_headers: false,
        skip_blanks: true
      ) do |row|
        row_number += 1

        next if row.fields.compact.empty?

        # convert to hash, and keep only defined fields
        row = row.to_hash.slice(*HEADERS)

        unless row.fetch_values(*REQUIRED_FIELDS).all?
          ActionLog.create!(
            sequence_id: sequence_id,
            tag: 'csv_job',
            message: "#{file_name(path)}: Missing required fields."
          )

          error!(current_user, row_number, 'Missing required fields.')
        end

        if row[:location_clps].present?
          row[:location_clps] = row[:location_clps].split(',')
        end

        user = User.create(
          **row,
          company_id: current_user.company_id,
          role: :user,
          imported: true
        )

        if user.invalid?
          ActionLog.create!(
            sequence_id: sequence_id,
            tag: 'csv_job',
            message: "#{file_name(path)}: #{user.errors.full_messages.join(', ')}."
          )

          error!(current_user, row_number, user.errors.full_messages.join(', '))
        end
      end

      ActionLog.create!(
        sequence_id: sequence_id,
        tag: 'csv_job',
        message: "#{file_name(path)}: #{row_number} user(s) imported."
      )

      ImportsChannel.broadcast_to(
        current_user,
        type: :completed,
        message: "#{row_number} user(s) imported successfully."
      )
    end
  ensure
    FileUtils.rm(path)
  end

  def error!(current_user, row_number, message)
    ImportsChannel.broadcast_to(
      current_user,
      type: :error,
      error: "CSV Line #{row_number}: #{message}"
    )

    raise ActiveRecord::Rollback
  end

  def sequence_id
    @sequence_id ||= ActionLog.sequence_id
  end

  def file_name(path)
    @file_name ||= File.basename(path)
  end
end
