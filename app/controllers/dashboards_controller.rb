class DashboardsController < ApplicationController
  def index
    @current_weather = nil
    @forecast_weather = []

    if geocoder_response.valid?
      weather_forecast = WeatherApi::Factory.build(lat: latitude, lon: longitude)
      if weather_forecast.error.present?
        @address = weather_forecast.error
      else
        @current_weather = weather_forecast.current_weather
        @forecast_weather = weather_forecast.forecast_weather
        @address = geocoder_response.address
      end
    else
      @address = "Please enter a valid address."
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
