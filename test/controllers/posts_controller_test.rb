# frozen_string_literal: true

require_relative '../test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @category = categories(:one)

    @attrs = {
      title: Faker::Movies::HarryPotter.character,
      body: Faker::Lorem.paragraph_by_chars(number: 256),
      category_id: @category.id
    }
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test 'should not get new if unauthorized user' do
    get new_post_url
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should create post' do
    sign_in @user
    post posts_url, params: { post: @attrs }

    new_post = Post.find_by @attrs
    assert_redirected_to post_url(new_post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end
