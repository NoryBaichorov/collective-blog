require_relative "../test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    host! 'localhost:3000'
    
    @user = users(:one)
    @post = posts

    @attrs = {
      title: Faker::String.random(length: 10),
      body: Faker::String.random(length: 220),
      category_id: 1,
      creator: 'nory.baichorov@gi.com'
    }
    
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test "should unathorized user can't create post" do
    get new_post_url
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should get new' do
    sign_in @user
    
    get new_post_url
    
    assert_response :success
  end

  test 'should create post' do
    post posts_url, params: { post: @attrs }

    assert_response :success
    assert_redirected_to root_path
    assert_select 'div', { class: 'alert alert-primary' }, 'Пост был создан.'
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end
end
