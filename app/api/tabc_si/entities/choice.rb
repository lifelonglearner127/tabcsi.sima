# frozen_string_literal: true

module TabcSi
  module Entities
    class Choice < Grape::Entity
      expose :id
      expose :choice_text, as: :text
      expose :picture_attachment
      expose :fields, using: Entities::Field
    end
  end
end
