# frozen_string_literal: true

require 'csv'
require 'tempfile'

class ReportsJob < ApplicationJob
  MOUNTAIN_TIME_COUNTIES = %w[El\ Paso Hudspeth].freeze
  BASE_HEADERS = %i[
    report_number clp address county expiration_date received
  ].freeze

  OTHER_HEADERS = %i[
    started_at completed_at days_to_complete inspection_flag
    inspection_flag_reason front_latitude front_longitude variance
  ].freeze

  FULL_HEADERS = (BASE_HEADERS + OTHER_HEADERS).freeze

  queue_as :default

  def perform(report)
    fiscal_year = report.fiscal_year
    include_received = report.include_received

    received =
      Inspection.where(fiscal_year: fiscal_year).where.not(submitted_at: nil)

    rows =
      if include_received
        relation = received.includes(location: :licenses).order(:started_at)

        relation.map do |inspection|
          location = inspection.location
          time_zone = self.time_zone(location)

          {
            **report_start(inspection.report_number, location, true),
            started_at: format_date_time(inspection.started_at, time_zone),
            completed_at: format_date_time(inspection.completed_at, time_zone),
            days_to_complete:
              days_to_complete(fiscal_year, inspection.completed_at),
            inspection_flag: inspection.flagged ? 'Yes' : 'No',
            inspection_flag_reason: inspection.flag_reason,
            front_latitude: location.front_lat,
            front_longitude: location.front_long,
            variance: location.unpadded_diameter
          }
        end
      else
        Location
          .includes(:licenses)
          .where
          .not(id: received.pluck(:location_id))
          .order(:clp)
          .map { |location| report_start(nil, location, false) }
      end

    file_name =
      "report-#{fiscal_year}" \
      "-#{include_received ? 'received' : 'not_received'}" \
      "-#{Time.current.strftime('%Y%m%d%H%M%SZ')}.csv"
    temp_path = Rails.root.join('tmp', file_name)

    CSV.open(
      temp_path,
      'wb',
      col_sep: '|',
      headers: include_received ? FULL_HEADERS : BASE_HEADERS,
      write_headers: true
    ) do |csv|
      rows.each { |row| csv << row }
    end

    report.file.attach(
      io: File.open(temp_path),
      filename: file_name,
      content_type: 'text/csv'
    )

    File.unlink(temp_path)

    ReportsChannel.broadcast_to(
      report.user,
      type: :completed,
      report: report.to_hash
    )
  end

  def days_to_complete(fiscal_year, completed_at)
    start_time = Time.zone.local(fiscal_year - 1, 9, 1)
    ((completed_at - start_time) / 86_400.0).round(half: :even)
  end

  def format_date(date, time_zone)
    format_timestamp(date, time_zone, '%F')
  end

  def format_date_time(date_time, time_zone)
    format_timestamp(date_time, time_zone, '%F %T %:z')
  end

  def format_timestamp(timestamp, time_zone, format)
    return nil if timestamp.blank?

    timestamp.in_time_zone(time_zone).strftime(format)
  end

  def location_address(location)
    "#{location.address1} #{location.city} #{location.state}" \
    " #{location.postal_code}"
  end

  def report_start(report_number, location, received)
    license = location.licenses.first

    {
      report_number: report_number,
      clp: location.clp,
      address: location_address(location),
      county: location.county,
      expiration_date: format_date(license.expires_on, time_zone(location)),
      received: received ? 'Yes' : 'No'
    }
  end

  def time_zone(location)
    if MOUNTAIN_TIME_COUNTIES.include?(location.county)
      'Mountain Time (US & Canada)'
    else
      'Central Time (US & Canada)'
    end
  end
end
