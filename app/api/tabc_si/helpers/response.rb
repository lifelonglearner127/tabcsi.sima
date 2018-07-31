# frozen_string_literal: true

module TabcSi
  module Helpers
    module Response
      # Use route's success model for data representation.
      def respond(data, **options)
        success_object = route.settings.dig(:description, :success)
        model = success_object[:model]
        options = { with: model }.merge(options) if model.present?

        status success_object[:code] if success_object[:code].present?

        present data, **options
      end
    end
  end
end
