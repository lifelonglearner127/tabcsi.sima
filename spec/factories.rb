# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name 'MyText'
  end

  factory :field do
    choice nil
    label 'MyString'
    field_type 1
  end

  factory :license do
    license_number 'MyString'
    front_lat '9.99'
    front_long '9.99'
    back_lat '9.99'
    back_long '9.99'
  end

  factory :answer do
    question nil
    license_number 'MyString'
    answer_value 'MyText'
  end

  factory :audit_form_question do
    audit_form nil
    question nil
    next_question 'MyString'
    finish false
  end

  factory :condition do
    question nil
    conditional_question_number 'MyString'
    condition_value 'MyString'
  end

  factory :choice do
    question nil
    choice_text 'MyString'
    picture_attachment false
  end

  factory :question do
    question_number 'MyString'
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
