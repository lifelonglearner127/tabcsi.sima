# frozen_string_literal: true

module TabcSi
  module Entities
    class VendorNamesEntity < Grape::Entity
      present_collection true

      expose(
        :items,
        documentation: {
          is_array: true,
          desc: 'The set of vendor names.'
        }
      )
    end
  end
end
