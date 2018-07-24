# frozen_string_literal: true

class SettingSerializer < ActiveModel::Serializer
  attributes :name, :value
end
