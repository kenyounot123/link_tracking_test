require "test_helper"

class StoreClickDataJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper
  test "link click data is stored with correct arguments" do
    link_click_params = { url: "example.com", referrer: "some_referrer", user_agent: "Windows" }
    ip_address = "123:01:2312"
    perform_enqueued_jobs do
      StoreClickDataJob.perform_later(link_click_params, ip_address)
    end

    assert_difference "LinkClick.count", 1 do
      perform_enqueued_jobs do
        StoreClickDataJob.perform_later(link_click_params, ip_address)
      end
    end
  end
  # test "#create enqueues a store click data job" do
  # end
end
