# frozen_string_literal: true

module TabcSi
  module Entities
    class VendorNames < Grape::Entity
      present_collection true
      expose :items, documentation: { is_array: true }
    end
  end
end