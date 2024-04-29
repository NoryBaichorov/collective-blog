# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def resource_post
    @resource_post ||= @post = Post.find(params[:post_id])
  end

  def authenticate
    return unless current_user.nil?

    redirect_to root_path
    flash[:danger] = 'Войдите в свой аккаунт или зарегистрируйтесь!'
  end
end
