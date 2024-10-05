class Admins::LinkClicksController < ApplicationController
  def index
    @total_clicks = LinkClick.total_clicks
    @most_clicked_link = LinkClick.most_clicked
    @active_links = LinkClick.active_links
    @top_clicked_links = LinkClick.top_clicked_links(7)
  end
end
