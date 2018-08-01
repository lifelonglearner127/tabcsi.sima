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
          associations.map { |a| __send__(a) }
        end

        define_method :last_updated_at do
          [
            updated_at,
            last_updated_at_associations.flatten.map(&:last_updated_at)
          ].max
        end
      end
    end
  end
end
