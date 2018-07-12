# frozen_string_literal: true

FactoryBot.define do
  factory :push_token do
    user nil
    device_type 0
    token 'MyText'
  end

  factory :user do
  end
end
