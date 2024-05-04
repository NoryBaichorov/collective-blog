# frozen_string_literal: true

module Posts
  class LikesController < Posts::ApplicationController
    before_action :authenticate_user!

    def create
      resource_post.likes.find_or_create_by(user: current_user)
      redirect_to resource_post
    end

    def destroy
      @like = PostLike.find(params[:id])
      return if @like.blank?

      @like.destroy if @like.user == current_user
      redirect_to resource_post
    end
  end
end
