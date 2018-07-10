# frozen_string_literal: true

FactoryBot.define do
  factory :jwt_blacklist do
    jti 'MyString'
    exp '2018-07-06 16:02:48'
  end

  factory :user do
  end
end
