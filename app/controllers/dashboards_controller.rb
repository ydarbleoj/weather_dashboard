class DashboardsController < ApplicationController
  def index
    @address = dashboard_params[:address]
    p results = Geocoder.search(@address)
    @location_name = results.first&.address
    @full_address = results.first&.formatted_address
  end

  private

  def parse_results(results)
    return {} if results.empty?

    {
      latitude: results.first.latitude,
      longitude: results.first.longitude,
      address: results.first.address,
      formatted_address: results.first.formatted_address
    }
  end

  def dashboard_params
    params.permit(:address)
  end
end
