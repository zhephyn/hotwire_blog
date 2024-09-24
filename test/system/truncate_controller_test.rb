require "application_system_test_case"

class TruncateTest < ApplicationSystemTestCase
  test "truncate long post content" do
    post = posts(:one)
    post.update(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras interdum felis at nulla facilisis, sed lacinia libero venenatis. Integer posuere sapien eget orci vehicula tincidunt.
")

    visit posts_path

    # Verify that the post's content is truncated
    within("#post_#{post.id}") do
      assert_text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vesti..."
      assert_selector "button", text: "Show More"
    end

    # Click "Show more" and check if the full content is revealed
    click_on "Show More"
    
    within("#post_#{post.id}") do
      assert_text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras interdum felis at nulla facilisis, sed lacinia libero venenatis. Integer posuere sapien eget orci vehicula tincidunt."
      assert_selector "button", text: "Show less"
    end

    # Click "Show less" and check if content is truncated again
    click_on "Show less"
    
    within("#post_#{post.id}") do
      assert_text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vesti..."
      assert_selector "button", text: "Show More"
    end
  end
end
