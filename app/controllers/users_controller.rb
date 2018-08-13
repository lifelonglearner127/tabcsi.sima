# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    build_user
  end

  def create
    build_user
    save_user || render('new')
  end

  private

  def build_user
    @user ||= user_scope.build
    @user.attributes = sign_up_params
  end

  def save_user
    redirect_to new_user_path if @user.save_admin
  end

  def sign_up_params
    return {} if action_name == 'new'

    params.require(:user).permit(
      :full_name, :email, :phone, :company_name, :job_title, :license_number
    )
  end

  def user_scope
    User.all
  end
end
