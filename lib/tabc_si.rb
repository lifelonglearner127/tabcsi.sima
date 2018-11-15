# frozen_string_literal: true

module TabcSi
  VERSION = '2.0.1'

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

  def self.transform_keys(object)
    if object.respond_to?(:deep_transform_keys!)
      object.deep_transform_keys! { |k| k.to_s.underscore.camelize(:lower) }
    else
      object
    end
  end

  def self.transform_response_json(object)
    # Ensure object is a JSON object or array.
    new_object = Oj.load(object.to_json)

    if new_object.is_a?(Array)
      new_object.each { |o| transform_keys(o) }
    else
      transform_keys(new_object)
    end

    new_object
  end
end
