# frozen_string_literal: true

require_relative '../test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)

    @post = posts(:one)
    @comment = post_comments(:one)
    @nested_comment = post_comments(:nested)
  end

  test 'should create comment' do
    post post_comments_path(@post), params: { post_comment: { content: @comment.content } }

    created_post_comment =
      PostComment.find_by(
        post_id: @comment.post_id,
        ancestry: @comment.ancestry,
        content: @comment.content
      )

    assert(created_post_comment)
    assert_redirected_to post_url(@post)
  end

  test 'should create nested comment' do
    post post_comments_path(@post), params: { post_comment: { content: @nested_comment.content,
                                                              parent_id: ActiveRecord::FixtureSet.identify(:one) } }

    created_post_comment =
      PostComment.find_by(
        post_id: @nested_comment.post_id,
        ancestry: @nested_comment.ancestry,
        content: @nested_comment.content
      )

    assert(created_post_comment)
    assert_redirected_to post_url(@post)
  end
end
