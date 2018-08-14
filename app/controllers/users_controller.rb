# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_page_options

  def new; end

  def create
    user = User.build
    user.attributes = params.require(:user).permit(
      :full_name, :email, :phone, :company_name, :job_title, :license_number
    )

    if user.save_admin
      redirect_to log_in_path
    else
      render 'new'
    end
  end

  private

  def set_page_options
    self.page_data_options = {
      url: sign_up_path,
      method: 'post',
      local: true
    }
  end
end
