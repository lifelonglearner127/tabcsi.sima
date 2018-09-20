# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logged_in_user, only: %i[invite]
  before_action :set_page_options

  def new
    redirect_to(dashboard_url) if logged_in?
  end

  def create
    user = User.new(user_params)

    if user.save_user
      flash[:notice] = 'Registration success!'
      redirect_to successful_create_url(user)
    else
      render unsuccessful_create_action(user)
    end
  end

  def invite; end

  private

  def set_page_options
    self.page_data_options =
      case action_name
      when 'invite'
        {
          url: invite_path,
          method: 'post',
          local: true,
          html: {
            is_invite: true,
            company_name: current_user.company.name
          }
        }
      else
        {
          url: sign_up_path,
          method: 'post',
          local: true
        }
      end
  end

  def successful_create_url(user)
    user.invite? ? dashboard_url : log_in_url
  end

  def unsuccessful_create_action(user)
    user.invite? ? 'invite' : 'new'
  end

  def user_params
    params.require(:user).permit(
      :company_name, :email, :full_name, :is_invite, :job_title,
      :license_number, :phone
    )
  end
end
