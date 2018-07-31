# frozen_string_literal: true

module TabcSi
  module Entities
    class Field < Grape::Entity
      expose :label
      expose :field_type, as: :type
    end
  end
end
