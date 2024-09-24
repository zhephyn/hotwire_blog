require "application_system_test_case"

class FlashTest < ApplicationSystemTestCase
  test "flash message disappears after timeout" do
    # Trigger the flash message by creating a post (or some action that triggers the flash)
    visit new_post_path

    fill_in "Body", with: "Test post for flash message"
    click_on "Create New Post"

    assert_selector "#flash", text: "Post was successfully created"

    # Wait for 3 seconds for the flash to disappear
    sleep 3.5

    # Verify that the flash message has been removed
    within("turbo-frame#flash") do
      assert_no_selector "#flash"
    end
  end
end
