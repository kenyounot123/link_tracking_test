class StoreClickDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    link_click_params = args[0]
    ip_address = args[1]
    link_click_params[:ip_address] = ip_address
    LinkClick.create!(link_click_params)
  end
end
