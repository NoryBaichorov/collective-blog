# frozen_string_literal: true

require_relative '../test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)

    sign_in @user
  end

  test 'should create like' do
    post post_likes_path(@post)

    like = PostLike.find_by({ post: @post, user: @user })

    assert { like }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy like' do
    like = post_likes(:one)
    delete post_like_path(@post, like)
    assert_not PostLike.find_by(id: like.id)
    assert_redirected_to post_url(@post)
  end
end
