# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: :create
  after_action :remove_notice

  def new
    super
  end

  def create
    super do |user|
      flash[:danger] = user.errors.full_messages.join(' ') unless user.persisted?
    end
  end

  def destroy
    super
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end

  def remove_notice
    flash.delete(:notice)
  end
end
