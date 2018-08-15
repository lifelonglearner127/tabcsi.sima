# frozen_string_literal: true

# Preview all emails at /rails/mailers/users
class UsersPreview < ActionMailer::Preview
  # Preview this email at /rails/mailers/users/request_pin
  def request_pin
    UsersMailer.with(pin: Faker::Number.number(8)).request_pin
  end
end
