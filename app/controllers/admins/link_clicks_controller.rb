class Admins::LinkClicksController < ApplicationControllerdef index
  @total_clicks = Rails.cache.fetch("#{cache_key_with_version}/total_clicks", expires_in: 12.hours) do
    LinkClick.total_clicks
  end

  @most_clicked_link = Rails.cache.fetch("#{cache_key_with_version}/most_clicked_link", expires_in: 12.hours) do
    LinkClick.most_clicked
  end

  @active_links = Rails.cache.fetch("#{cache_key_with_version}/active_links", expires_in: 12.hours) do
    LinkClick.active_links
  end

  @top_clicked_links = Rails.cache.fetch("#{cache_key_with_version}/top_clicked_links", expires_in: 12.hours) do
    LinkClick.top_clicked_links(7)
  end
end
