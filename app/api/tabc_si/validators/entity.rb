# frozen_string_literal: true

module TabcSi
  module Validators
    class Entity < Id
      def validate_param!(attr_name, params)
        super

        id = params[attr_name]
        entity = entity_class.find_by(id: id)
        params[entity_name] = entity

        validation_failed!(entity_name, :entity) if entity.blank?

        params.delete(attr_name) if delete_id?
      end

      private

      def entity_class
        @entity_class ||= option_value
      end

      def entity_name
        @entity_name ||= name_option.to_sym
      end

      def name_option
        options_key?(:name) ? @option[:name] : entity_class.to_s.underscore
      end

      def delete_id?
        options_key?(:delete_id) ? @option[:delete_id] : false
      end
    end
  end
end
