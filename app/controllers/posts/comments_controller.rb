# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :set_comment_params

    def create
      if @comment.save
        redirect_to post_path(@post)
        flash[:primary] = t('comments.create')
      else
        redirect_back(fallback_location: post_path(@post))
        flash[:danger] = @comment.errors.full_messages.join(' ')
      end
    end

    protected

    def set_comment_params
      @comment = resource_post.comments.build(comment_params)
      @comment.user = current_user
    end

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
