# frozen_string_literal: true

module Api
  module V1
    class VendorsController < BaseV1Controller
      def names
        success!(
          %w[
            Spec's\ Wine,\ Spirits\ &\ Finer\ Foods
            Test\ Bar\ &\ Grill
          ]
        )
      end
    end
  end
end

