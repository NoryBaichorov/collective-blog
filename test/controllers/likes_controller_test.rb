# frozen_string_literal: true

require_relative '../test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @post_without_like = posts(:two)

    sign_in @user
  end

  test 'should create like' do
    post post_likes_path(@post_without_like)

    like = PostLike.find_by({ post: @post_without_like, user: @user })

    assert { like }
    assert_redirected_to post_url(@post_without_like)
  end

  test 'should destroy like' do
    like = post_likes(:one)
    delete post_like_path(@post, like)
    assert_not { @post.likes.find(like.id).nil? }
    assert_redirected_to post_url(@post)
  end
end
