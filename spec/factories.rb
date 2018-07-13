# frozen_string_literal: true

FactoryBot.define do
  factory :audit_form do
    permit_name 'MyString'
  end

  factory :push_token do
    user nil
    device_type 0
    token 'MyText'
  end

  factory :user do
  end
end
