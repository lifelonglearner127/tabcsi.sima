# frozen_string_literal: true

module TabcSi
  module V1
    class VendorsApi < Grape::API
      resources :vendors do
        desc(
          'Get Vendor Names',
          detail: 'Retrieves all vendor names.',
          success: {
            model: Entities::VendorNames,
            message: 'A collection of vendor names.'
          }
        )
        get :names do
          %w[
            Spec's\ Wine,\ Spirits\ &\ Finer\ Foods
            Test\ Bar\ &\ Grill
          ]
        end
      end
    end
  end
end
