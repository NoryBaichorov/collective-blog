# frozen_string_literal: true

module Posts
  class CommentsController < Posts::ApplicationController
    before_action :authenticate_user!

    def create
      @comment = resource_post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to post_path(@post)
        flash[:primary] = t('comments.create')
      else
        redirect_back(fallback_location: post_path(@post))
        flash[:danger] = @comment.errors.full_messages.join(' ')
      end
    end

    protected

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
