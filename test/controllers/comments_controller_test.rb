require_relative "../test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = post_comments(:one)

    @attrs = {
      content: Faker::Lorem.paragraph(random_sentences_to_add: 10)
    }
    @nested_attrs = @attrs.merge({ parent_id: @parent_comment.id.to_s })

    sign_in @user
  end

  test 'should create comment' do
    post post_comments_url(@post), params: { post_comment: @attrs }

    comment = PostComment.find_by @attrs.merge({ post: @post, user: @user })

    assert { comment }
    assert_redirected_to @post
  end

  test 'should create children comment' do
    post post_comments_url(@post), params: { post_comment: @nested_attrs }

    comment = PostComment.find do |i|
      i.ancestry == @nested_attrs[:parent_id] && i.post == @post && i.user == @user
    end

    assert { comment }
    assert_redirected_to @post
  end
end
