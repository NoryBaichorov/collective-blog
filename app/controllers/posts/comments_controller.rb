# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController    
    before_action :find_post

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to post_path(@post)
        flash[:primary] = 'Комментарий был добавлен'
      else
        redirect_back(fallback_location: post_path(@post))
        flash[:danger] = @comment.errors.full_messages.join(' ')
      end
    end

    protected

    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
