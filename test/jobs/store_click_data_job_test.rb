require "test_helper"

class StoreClickDataJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper
  test "should store link click data to database" do
    link_click_params = { url: "example.com", referrer: "some_referrer", user_agent: "Windows", ip_address: "123:01:2312" }
    perform_enqueued_jobs do
      StoreClickDataJob.perform_later(link_click_params)
    end

    assert_difference "LinkClick.count", 1 do
      perform_enqueued_jobs do
        StoreClickDataJob.perform_later(link_click_params)
      end
    end
  end
end
