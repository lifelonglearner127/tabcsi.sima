# frozen_string_literal: true

module TabcSi
  module Builders
    class HelpBuilder < Builder
      attr_reader :images
      attr_reader :items
      attr_reader :question_builder

      def initialize(question_builder, config)
        super(config)

        @question_builder = question_builder
      end

      def build
        items.each(&:build)
        images.each(&:build)
      end

      protected

      def parse_config
        super

        @items = wrap_items(config[:items] || [])
        @images = wrap_images(config[:images] || [])
      end

      private

      def wrap_images(images)
        sort_order = 0
        images.map do |image|
          sort_order += 1

          HelpImageBuilder.new(
            self,
            path: image,
            sort_order: sort_order
          )
        end
      end

      def wrap_items(items)
        sort_order = 0
        items.map do |item|
          sort_order += 1

          HelpItemBuilder.new(
            self,
            value: item,
            sort_order: sort_order
          )
        end
      end
    end
  end
end
