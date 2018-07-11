# Preview all emails at http://localhost:3000/rails/mailers/users
class UsersPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/users/request_pin
  def request_pin
    UsersMailer.request_pin
  end
end
