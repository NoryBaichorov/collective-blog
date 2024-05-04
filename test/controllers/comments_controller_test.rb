# frozen_string_literal: true

require_relative '../test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)

    @post = posts(:one)
    @comment = post_comments(:one)

    @attrs = {
      content: 'content',
      post_id: @post.id,
      user_id: @comment.user.id
    }
    @nested_attrs = @attrs.merge({ parent_id: @comment.id.to_s })
  end

  test 'should create comment' do
    post post_comments_path(@post), params: { post_comment: @attrs }

    created_post_comment = PostComment.find_by @attrs

    assert { created_post_comment }
    assert_redirected_to post_url(@post)
  end

  test 'should create nested comment' do
    assert_difference('PostComment.count') do
      post post_comments_path(@post), params: { post_comment: @nested_attrs }
    end

    assert_equal "/#{@comment.id}/", PostComment.last.ancestry
  end
end
