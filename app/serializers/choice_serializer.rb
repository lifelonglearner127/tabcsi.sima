# frozen_string_literal: true

class ChoiceSerializer < ActiveModel::Serializer
  attributes :id, :picture_attachment
  attribute :choice_text, key: :text
end
