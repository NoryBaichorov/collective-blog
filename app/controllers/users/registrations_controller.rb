# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def new
    super
  end

  def create
    super do |user|
      if user.save
        sign_in(user)
        redirect_to root_path and return
        flash[:notice] = 'You have been successfully signed up'
      else
        flash[:failure] = user.errors.full_messages.join(' ')
      end
    end
  end

  # def edit
  #   super
  # end

  # def update
  #   super
  # end

  # def destroy
  #   super
  # end

  # def cancel
  #   super
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name password password_confirmation])
  end
end
