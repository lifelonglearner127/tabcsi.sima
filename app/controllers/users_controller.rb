# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_page_options

  def new
    redirect_to(dashboard_url) if logged_in?
  end

  def create
    user = User.new(
      params.require(:user).permit(
        :full_name, :email, :phone, :company_name, :job_title, :license_number
      )
    )

    if user.save_admin
      flash[:notice] = 'Registration success!'
      redirect_to log_in_url
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
