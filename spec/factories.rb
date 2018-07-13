# frozen_string_literal: true

FactoryBot.define do
  factory :choice do
    question nil
    choice_text 'MyString'
    picture_attachment false
  end

  factory :question do
    question_id 'MyString'
    question_text 'MyText'
    question_type 1
    max_characters 0
    multiline false
  end

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
