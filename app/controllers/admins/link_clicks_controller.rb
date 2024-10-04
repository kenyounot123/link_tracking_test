class Admins::LinkClicksController < ApplicationController
  def index
    @link_clicks = LinkClick.all
  end
end
