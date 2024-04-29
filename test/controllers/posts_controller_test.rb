require_relative "../test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do    
    @user = users(:one)
    @post = posts(:one)

    @attrs = {
      title: Faker::String.random(length: 10),
      body: Faker::String.random(length: 220),
      category_id: 1,
    }
    sign_in @user
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  # test "should unathorized user can't create post" do
  #   get new_post_url
  #   assert_response :redirect
  #   assert_redirected_to root_path
  # end

  test 'should get new' do    
    get new_post_url
    
    assert_response :success
  end

  test 'should create post' do
    post posts_url, params: { post: @attrs }

    post = Post.find_by @attrs

    assert_response :success
    assert_redirected_to post_url(post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end
