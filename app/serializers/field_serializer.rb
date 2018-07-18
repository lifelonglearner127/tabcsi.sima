# frozen_string_literal: true

class FieldSerializer < ActiveModel::Serializer
  attributes :label
  attribute :field_type, key: :type
end
