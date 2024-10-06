class LinkClicksController < ApplicationController
  def create
    # Here we will handle when client sends us link_click data
    # we want to offload this request to be handled by a background job using solid_queue
    link_click_params_with_ip = link_click_params.merge(ip_address: request.ip)

    StoreClickDataJob.perform_later(link_click_params_with_ip)
    respond_to do |format|
      format.json { render json: { message: "click data will be saved as a background job" }, status: :accepted }
    end
  end

  private

  def link_click_params
    params.require(:link_click).permit(:url, :anchor_text, :referrer, :user_agent, :ip_address)
  end
end
