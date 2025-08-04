class DashboardsController < ApplicationController
  def index
    @address = "Please enter a valid address."
    return @address if geocoder_response.blank?

    weather_response = Rails.cache.fetch("weather_response/#{geocoder_response.postal_code}", expires_in: 30.minutes) do
       WeatherApi::Factory.build(lat: latitude, lon: longitude)
    end

    if weather_response.error?
      @address = weather_response.error
    else
      @current_weather = weather_response.current_weather
      @forecast_weather = weather_response.forecast_weather
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
    @geocoder_response ||= Rails.cache.fetch("geocoder_response/#{dashboard_params[:address] || 'Portland, OR'}", expires_in: 24.hours) do
      GeocoderFactory.build(dashboard_params[:address] || "Portland, OR")
    end
  end

  def dashboard_params
    params.permit(:address)
  end
end
