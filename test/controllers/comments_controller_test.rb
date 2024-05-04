# frozen_string_literal: true

require_relative '../test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = post_comments(:one)

    sign_in @user

    @attrs = { content: Faker::Lorem.sentence }
  end

  test 'should create comment' do
    post post_comments_path(@post), params: { post_comment: @attrs }

    created_post_comment = PostComment.find_by @attrs.merge(post_id: @post.id, user_id: @user.id)

    assert { created_post_comment }
    assert_redirected_to post_url(@post)
  end

  test 'should create nested comment' do
    @nested_attrs = @attrs.merge({ parent_id: @comment.id.to_s })

    post post_comments_path(@post), params: { post_comment: @nested_attrs }

    created_post_comment = PostComment.find_by @attrs.merge(post_id: @post.id, user_id: @user.id)

    assert { created_post_comment }
    assert { created_post_comment.ancestry == "/#{@comment.id}/" }
    assert_redirected_to post_url(@post)
  end
end
