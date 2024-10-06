require "test_helper"

class LinkClicksControllerTest < ActionDispatch::IntegrationTest
  test "should enqueue StoreClickDataJob" do
    assert_enqueued_with(job: StoreClickDataJob) do
      post link_clicks_path, params: { link_click: {
        url: "example.com",
        anchor_text: "some_url",
        referrer: "some_referrer",
        user_agent: "some_user_agent"
      } }
    end
    assert_response :created
  end
end
