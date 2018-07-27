# frozen_string_literal: true

module TabcSi
  module V1
    class VendorsApi < Grape::API
      resources :vendors do
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
