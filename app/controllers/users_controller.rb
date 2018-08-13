# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    build_sign_up_user
    set_sign_up_data
  end

  def create
    build_sign_up_user
    set_sign_up_data
    save_sign_up_user || render('new')
  end

  private

  def build_sign_up_user
    @sign_up_user ||= user_scope.build
    @sign_up_user.attributes = sign_up_user_params
  end

  def set_sign_up_data
    self.page_data_options = {
      model: @sign_up_user,
      local: true
    }
  end

  def save_sign_up_user
    redirect_to log_in_users if @sign_up_user.save_admin
  end

  def sign_up_user_params
    return {} if action_name == 'new'

    params.require(:user).permit(
      :full_name, :email, :phone, :company_name, :job_title, :license_number
    )
  end

  def user_scope
    User.all
  end
end
