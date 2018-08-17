# frozen_string_literal: true

module TabcSi
  module V1
    class VendorsApi < Grape::API
      resources :vendors do
        desc(
          'Get Vendor Names',
          detail: 'Retrieves all vendor names.',
          success: {
            model: Entities::VendorNamesEntity,
            message: 'A collection of vendor names.'
          }
        )
        get :names do
          respond Location.order(name: :asc).pluck(:name).uniq
        end
      end
    end
  end
end
