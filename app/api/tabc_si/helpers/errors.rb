# frozen_string_literal: true

module TabcSi
  module Helpers
    module Errors
      {
        not_found: 'Resource not found.'
      }.each do |code, message|
        define_method "#{code}_error!" do
          raise Error.new(message, status: code)
        end
      end

      def bad_request_error!(title, detail: nil, code: nil)
        raise Error.new(title, detail: detail, code: code)
      end

      def clean_backtrace(error)
        backtrace = error.backtrace

        return unless backtrace

        Rails.backtrace_cleaner.clean(backtrace, :all)
      end

      def create_error_object(status:, code:, title:, detail:, source:)
        obj = {
          status: status.to_s,
          code: code.to_s,
          title: title,
          detail: detail
        }

        obj[:source] = source if source.present?

        obj
      end
    end
  end
end
