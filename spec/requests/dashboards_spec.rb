require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    let(:address) { "97206" }

    let(:geocoder_response) do
      double(
        "GeocoderResponse",
        postal_code: "97206",
        latitude: 45.5202471,
        longitude: -122.674194,
        address: "Portland, OR",
        error?: false
      )
    end

    let(:weather) do
      double(
        "Weather",
        temperature: 68,
        high: 75,
        low: 60,
        date: "2025-08-01"
      )
    end

    let(:weather_response) do
      double(
        "WeatherApi::ResponseHandler",
        current_weather: weather,
        forecast_weather: [weather],
        error?: false
      )
    end

    before do
      allow(GeocoderFactory).to receive(:build).and_return(geocoder_response)
      allow(WeatherApi::Factory).to receive(:build).and_return(weather_response)

      allow(Rails.cache).to receive(:fetch).and_call_original
      allow(Rails.cache).to receive(:fetch)
        .with("weather_response/97206", expires_in: 30.minutes)
        .and_return(weather_response)
    end

    it "returns http success and caches the weather response" do
      Rails.cache.clear

      expect(Rails.cache.exist?("weather_response/97206")).to be_falsey

      get "/dashboards/index", params: { address: address }
      expect(response).to have_http_status(:success)

      expect(Rails.cache.exist?("weather_response/97206")).to be_truthy

      # Now make a second request to ensure the cache is used
      expect(WeatherApi::Factory).to receive(:build).once

      get "/dashboards/index", params: { address: address }
      expect(response).to have_http_status(:success)
    end
  end
end
