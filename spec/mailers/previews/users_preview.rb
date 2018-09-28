# frozen_string_literal: true

# Preview all emails at /rails/mailers/users
class UsersPreview < ActionMailer::Preview
  # Preview this email at /rails/mailers/users/request_pin
  def request_pin
    UsersMailer.with(
      recipient: Faker::Internet.safe_email,
      full_name: Faker::Name.full_name,
      pin: Faker::Number.number(Setting.pin_length)
    ).request_pin
  end

  # Preview this email at /rails/mailers/users/welcome_admin
  def welcome_admin
    UsersMailer.with(
      recipient: Faker::Internet.safe_email,
      full_name: Faker::Name.full_name
    ).welcome
  end

  # Preview this email at /rails/mailers/users/welcome_user
  def welcome_user
    UsersMailer.with(
      recipient: Faker::Internet.safe_email,
      full_name: Faker::Name.full_name,
      company_name: Faker::Company.name
    ).welcome
  end
end
