class LinkClicksController < ApplicationController
  def create
    # Here we will handle when client sends us link_click data
    # we want to offload this request to be handled by a background job using solid_queue
    ip_address = request.ip

    # Might also want wait for more requests and store it in batch to submit to db
    StoreClickDataJob.perform_later(link_click_params, ip_address)

    head :created
  end

  private

  def link_click_params
    params.require(:link_click).permit(:url, :anchor_text, :referrer, :user_agent)
  end
end
