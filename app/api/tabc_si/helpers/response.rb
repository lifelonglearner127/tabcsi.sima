# frozen_string_literal: true

module TabcSi
  module Helpers
    module Response
      # Use route's success model for data representation.
      def respond(data, **options)
        success_object = route.settings.dig(:description, :success)
        model = success_object[:model]
        code = success_object[:code]
        options = { with: model }.merge(options) if model.present?

        status code if code.present?

        body(false) && return if data.nil? && code == 204

        present data, **options
      end

      def no_content
        respond nil
      end
    end
  end
end
