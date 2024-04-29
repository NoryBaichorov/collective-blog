# frozen_string_literal: true

module Posts
  class LikesController < ApplicationController
    before_action :authenticate
    before_action :set_like, only: :destroy

    def create
      resource_post.likes.create(user: current_user) unless liked?
      redirect_to resource_post
    end

    def destroy
      return unless @like.present?

      @like.destroy if @like.user == current_user
      redirect_to resource_post
    end

    protected

    def set_like
      @like = PostLike.find(params[:id])
    end

    def liked?
      resource_post.likes.exists?(user: current_user)
    end
  end
end
