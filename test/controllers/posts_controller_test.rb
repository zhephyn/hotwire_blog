
require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: { post: { body: "New post content" } }, as: :turbo_stream
    end

    assert_response :success
    assert_turbo_stream action: :prepend, target: "posts"
    assert_turbo_stream action: :update, target: "flash"
    assert_match /New post content/, response.body
    assert_match /Post was successfully created/, response.body
  end

  test "should update post" do
    patch post_url(@post), params: { post: { body: "Updated post content" } }, as: :turbo_stream

    assert_response :success
    assert_turbo_stream action: :update, target: "flash"
    assert_match /Post was successfully updated/, response.body
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post), as: :turbo_stream
    end

    assert_response :success
    assert_turbo_stream action: :remove, target: @post
    assert_turbo_stream action: :update, target: "flash"
    assert_match /Post was successfully deleted/, response.body
  end
end
