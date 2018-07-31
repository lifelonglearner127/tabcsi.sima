# frozen_string_literal: true

module TabcSi
  module Entities
    class Location < Grape::Entity
      expose :id
      expose :name
      expose :address1
      expose :address2
      expose :address3
      expose :city
      expose :county
      expose :state
      expose :country
      expose :postal_code
      expose :licenses, using: Entities::License
    end
  end
end
