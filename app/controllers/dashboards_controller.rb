class DashboardsController < ApplicationController
  def index
    @current_weather = nil
    @forecast_weather = []
    @address = "Please enter a valid address."

    return @address if geocoder_response.blank?

    response = WeatherApi::Factory.build(lat: latitude, lon: longitude)
    if response.error?
      @address = response.error
    else
      @current_weather = response.current_weather
      @forecast_weather = response.forecast_weather
      @address = geocoder_response.address
    end
  end

  private

  def longitude
    @geocoder_response.longitude
  end

  def latitude
    @geocoder_response.latitude
  end

  def geocoder_response
    @geocoder_response = GeocoderFactory.build(dashboard_params[:address] || "Portland, OR")
  end

  def dashboard_params
    params.permit(:address)
  end
end
