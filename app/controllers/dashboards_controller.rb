class DashboardsController < ApplicationController
  def index
    @address = "Please enter a valid address."
    return @address if geocoder_response.blank?

    @cache_present = Rails.cache.exist?(weather_cache_key)
    weather_response = Rails.cache.fetch(weather_cache_key, expires_in: 30.minutes) do
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

  def weather_cache_key
    "weather_response/#{geocoder_response.postal_code}"
  end

  def longitude
    @geocoder_response.longitude
  end

  def latitude
    @geocoder_response.latitude
  end

  def geocoder_response
    @geocoder_response ||= GeocoderFactory.build(dashboard_params[:address] || "Portland, OR")
  end

  def dashboard_params
    params.permit(:address)
  end
end
