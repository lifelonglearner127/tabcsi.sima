# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logged_in_user, only: %i[destroy invite profile]
  before_action :set_page_options
  before_action :set_user, only: %i[edit show update]

  def create
    user = User.new(sanitized_user_params)

    if user.save_user
      flash[:notice] = 'Registration success!'
      redirect_to successful_create_url(user)
    else
      unsuccessful_create_action(user)
    end
  end

  def destroy
    user = User.find(params[:id])
    user.discard

    head :no_content
  end

  def edit; end

  def invite; end

  def new
    redirect_to(dashboard_url) if logged_in?
  end

  def profile; end

  def update
    if @user.update!(sanitized_user_params)
      redirect_to dashboard_url
    else
      unsuccessful_update_action(@user)
    end
  end

  private

  def build_page_options(page_name)
    self.page_data_options =
      case page_name
      when 'invite'
        {
          url: invite_path,
          method: 'post',
          local: true,
          html: {
            page_name: 'invite',
            owner_name: current_user.company.owner_name,
            locations: current_user.company.locations.where(inspected: false)
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

  def sanitized_user_params
    sanitized_params = user_params

    if sanitized_params[:full_name].present?
      sanitized_params[:full_name] = sanitized_params[:full_name].strip
    end

    if sanitized_params[:license_number].present?
      sanitized_params[:license_number] = sanitized_params[:license_number].strip
    end

    sanitized_params
  end

  def set_page_options
    build_page_options(action_name)
  end

  def set_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def successful_create_url(user)
    user.invite? ? dashboard_url : log_in_url
  end

  def unsuccessful_create_action(user)
    if user.invite?
      build_page_options('invite')
      page_data_options[:html][:errors] = {
        base: user.errors.full_messages.join(', ')
      }

      render 'invite'
    else
      page_data_options[:html][:errors] = {
        base: user.errors.full_messages.join(', ')
      }

      render 'new'
    end
  end

  def unsuccessful_update_action(user)
    if user.profile?
      build_page_options('profile')
      render 'profile'
    else
      render 'edit'
    end
  end

  def user_params
    params
      .require(:user)
      .permit(
        :company_name, :email, :full_name, :is_invite, :is_profile, :job_title,
        :license_number, { location_clps: [] }, :owner_name, :phone, :role
      )
  end
end
