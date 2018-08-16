# frozen_string_literal: true

# Subscribe to grape request and log with Rails.logger
ActiveSupport::Notifications.subscribe('grape_key') do |_name, _starts, _ends, _notification_id, payload| # rubocop:disable Metrics/LineLength
  next unless Rails.logger.info?

  params = payload[:params]

  Rails.logger.info("  Parameters: #{params.inspect}") unless params.empty?

  response = payload[:response]
  response = [response] unless response.is_a?(Array)
  response = response.compact.first

  Rails.logger.info("  Response: #{response}") if response.present?

  time = payload[:time]
  additions = []

  view_runtime = time[:view]
  additions << format('Views: %.1fms', view_runtime.to_f) if view_runtime

  db_runtime = time[:db]
  additions << format('ActiveRecord: %.1fms', db_runtime.to_f) if db_runtime

  status = payload[:status]
  status = 400 if status == 'fail'
  status_text = Rack::Utils::HTTP_STATUS_CODES[status]

  # unary plus unfreezes string
  message = +"Completed #{status} #{status_text} in #{time[:total].round}ms"
  message << " (#{additions.join(' | ')})" unless additions.empty?
  message << "\n\n" if Rails.env.development?

  Rails.logger.info(message)
end
