# frozen_string_literal: true

module TabcSi
  module Entities
    class PhotoEntity < Grape::Entity
      expose :url
      expose :content_type
      expose :checksum
    end
  end
end
