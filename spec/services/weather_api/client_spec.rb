require "rails_helper"

RSpec.describe WeatherApi::Client do
  before do
    @described_class = described_class.new
  end

  describe ".fetch" do
    context "when the API call is successful" do
      before do
        @lat = 45.5202471
        @lon = -122.674194
      end

      it "returns a successful response" do
        VCR.use_cassette("weather_api/success/portland") do
          response = @described_class.fetch(lat: @lat, lon: @lon)

          expect(response).to have_key("location")
          expect(response).to have_key("current")
          expect(response).to have_key("forecast")
        end
      end
    end

    context "when the coordinates are invalid" do
      before do
        @lat = 9999.9999
        @lon = 9999.9999
      end

      it "returns an error response" do
        VCR.use_cassette("weather_api/failure/invalid_coordinates") do
          response= @described_class.fetch(lat: @lat, lon: @lon)

          expect(response[:code]).to eq(400)
          expect(response[:error]).to eq("Bad Request")
        end
      end
    end
  end
end
