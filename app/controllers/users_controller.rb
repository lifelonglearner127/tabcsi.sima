# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logged_in_user, only: %i[destroy edit invite update]
  before_action :set_user, only: %i[destroy edit show update]
  before_action :set_page_options, only: %i[edit invite new]

  def create
    @user = User.create(normalized_user_params)

    if @user.persisted?
      redirect_to(
        @user.invited? ? dashboard_url : log_in_url,
        notice: successful_create_notice(@user)
      )

      return
    end

    page_name, action = @user.invited? ? %w[invite invite] : [nil, 'new']

    build_page_options(page_name)

    render action
  end

  def destroy
    @user.discard

    head :no_content
  end

  def edit; end

  def invite; end

  def new
    redirect_to(dashboard_url) if logged_in?
  end

  def update
    if @user.update(normalized_user_params)
      redirect_to dashboard_url

      return
    end

    build_page_options('edit')

    render 'edit'
  end

  private

  def build_page_options(page_name = nil)
    self.page_data_options =
      case page_name
      when 'edit'
        {
          url: edit_user_path,
          method: 'patch',
          local: true,
          html: {
            is_profile: @user.id == current_user.id,
            locations: company_locations,
            page_name: 'edit'
          }
        }
      when 'invite'
        {
          url: invite_users_path,
          method: 'post',
          local: true,
          html: {
            locations: company_locations,
            owner_name: current_user.company.owner_name,
            page_name: 'invite'
          }
        }
      else
        {
          url: sign_up_path,
          method: 'post',
          local: true,
          html: { page_name: 'sign-up' }
        }
      end

    page_data_options[:html][:user] = @user&.info

    return if @user&.errors.blank?

    page_data_options[:html][:errors] = {
      base: @user.errors.full_messages.join(', ')
    }
  end

  def company_locations
    current_user.company.locations
  end

  def normalized_user_params
    normalized_params = user_params

    if normalized_params[:full_name].present?
      normalized_params[:full_name].strip!
    end

    if normalized_params[:license_number].present?
      normalized_params[:license_number].strip!
    end

    normalized_params
  end

  def set_page_options
    build_page_options(action_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def successful_create_notice(user)
    if user.invited?
      t('notices.users.create.invite')
    else
      t('notices.users.create.new')
    end
  end

  def user_params
    params
      .require(:user)
      .permit(
        :company_name, :edited, :email, :full_name, :invited, :job_title,
        :license_number, { location_clps: [] }, :owner_name, :phone, :role
      )
  end
end
