class DashboardsController < ApplicationController
  def index
    @city = geocoder_response.city
    @address = geocoder_response.address
  end

  private

  def geocoder_response
    @geocoder_response = GeocoderFactory.build(dashboard_params[:address] || "Portland, OR")
  end

  def dashboard_params
    params.permit(:address)
  end
end
