# frozen_string_literal: true

module LastUpdatable
  extend ActiveSupport::Concern

  class_methods do
    def last_updated_by(*associations)
      if associations.blank?
        define_method :last_updated_at do
          updated_at
        end
      else
        define_method :last_updated_at_associations do
          associations.map do |a|
            if a.respond_to?(:call)
              a.call
            else
              __send__(a)
            end
          end
        end

        define_method :last_updated_at do
          associations_last_updated_at =
            last_updated_at_associations
            .flatten
            .map(&:last_updated_at)
            .compact
            .max

          [
            updated_at,
            associations_last_updated_at
          ].compact.max
        end
      end
    end
  end
end
