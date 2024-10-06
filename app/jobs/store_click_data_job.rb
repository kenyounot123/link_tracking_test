class StoreClickDataJob < ApplicationJob
  queue_as :default

  def perform(link_click_params)
    LinkClick.create(link_click_params)
  rescue StandardError => e
    Rails.logger.error("Error saving link click data: #{e.message}")
  end
end
