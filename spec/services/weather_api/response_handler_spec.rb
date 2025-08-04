require "rails_helper"

RSpec.describe WeatherApi::ResponseHandler do
  context "when the response is valid" do
    before do
      VCR.use_cassette("weather_api/success/portland") do
        @lat = 45.5202471
        @lon = -122.674194
        @response = WeatherApi::Client.new.fetch(lat: @lat, lon: @lon)
      end
    end

    before do
      @described_class = described_class.new(@response.data)

      @current_weather = @described_class.current_weather
      @forecast = @described_class.forecast_weather
    end

    it "is valid" do
      expect(@described_class.valid?).to be_truthy
    end

    it "returns the current weather" do
      expect(@current_weather).to be_present
      expect(@current_weather.temperature).to eq(73.0)
      expect(@current_weather.high).to eq(73.4)
      expect(@current_weather.low).to eq(59.5)
      expect(@current_weather.date).to eq("2025-08-03")
    end

    it "returns a forecast array" do
      expect(@forecast.count).to eq(3)
    end

    it "returns the first forecast" do
      expect(@forecast.first).to be_present
      expect(@forecast.first.temperature).to eq(64.8)
      expect(@forecast.first.high).to eq(73.4)
      expect(@forecast.first.low).to eq(57.4)
      expect(@forecast.first.date).to eq("2025-08-04")
    end

    it "returns the second forecast" do
      expect(@forecast.second).to be_present
      expect(@forecast.second.temperature).to eq(67.2)
      expect(@forecast.second.high).to eq(78.1)
      expect(@forecast.second.low).to eq(57.6)
      expect(@forecast.second.date).to eq("2025-08-05")
    end

    it "returns the third forecast" do
      expect(@forecast.third).to be_present
      expect(@forecast.third.temperature).to eq(69.6)
      expect(@forecast.third.high).to eq(78.6)
      expect(@forecast.third.low).to eq(63.5)
      expect(@forecast.third.date).to eq("2025-08-06")
    end
  end
end