# frozen_string_literal: true

module TabcSi
  VERSION = '1.1.2'

  def self.create_logger(
    path_or_logger,
    formatter = Rails.application.config.log_formatter || Formatter.new
  )
    if path_or_logger.is_a?(Logger)
      logger = path_or_logger
    else
      path = path_or_logger.to_s

      unless File.exist?(File.dirname(path))
        FileUtils.mkdir_p(File.dirname(path))
      end

      logger = ActiveSupport::Logger.new(path, 'daily')
    end

    logger.formatter = formatter
    ActiveSupport::TaggedLogging.new(logger)
  end
end
