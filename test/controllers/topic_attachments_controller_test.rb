require 'test_helper'

class TopicAttachmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get topic_attachments_new_url
    assert_response :success
  end

  test "should get create" do
    get topic_attachments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get topic_attachments_destroy_url
    assert_response :success
  end

end
