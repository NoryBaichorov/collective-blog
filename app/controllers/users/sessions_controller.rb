# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params
    after_action :remove_notice

    protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    end

    def remove_notice
      flash.delete(:notice)
    end
  end
end
