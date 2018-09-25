# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logged_in_user, only: %i[destroy invite profile]
  before_action :set_page_options
  before_action :set_user, only: %i[edit show update]

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

  def profile; end

  def edit; end

  def update
    if @user.update!(user_params)
      redirect_to dashboard_url
    else
      unsuccessful_update_action(@user)
    end
  end

  def destroy
    user = User.find(params[:id])
    user.discard

    head :no_content
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def set_page_options
    self.page_data_options =
      case action_name
      when 'invite'
        {
          url: invite_path,
          method: 'post',
          local: true,
          html: {
            page_name: 'invite',
            owner_name: current_user.company.owner_name
          }
        }
      when 'profile'
        {
          url: profile_path,
          method: 'patch',
          local: true,
          html: {
            page_name: 'profile',
            user: current_user
          }
        }
      else
        {
          url: sign_up_path,
          method: 'post',
          local: true,
          html: {
            page_name: 'sign-up'
          }
        }
      end
  end

  def successful_create_url(user)
    user.invite? ? dashboard_url : log_in_url
  end

  def unsuccessful_create_action(user)
    user.invite? ? 'invite' : 'new'
  end

  def unsuccessful_update_action(user)
    user.profile? ? 'profile' : 'edit'
  end

  def user_params
    params.require(:user).permit(
      :company_name, :email, :full_name, :is_invite, :is_profile, :job_title,
      :license_number, :owner_name, :phone
    )
  end
end
