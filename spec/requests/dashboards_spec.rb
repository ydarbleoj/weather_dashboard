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
        error?: false,
        blank?: false
      )
    end

    before do
      Rails.cache.clear

      allow(GeocoderFactory).to receive(:build).with(address).and_return(geocoder_response)
      allow(WeatherApi::Factory).to receive(:build).and_call_original
    end

    it "returns http success and caches the weather response" do
      VCR.use_cassette("dashboards/index") do
        get "/dashboard/index", params: { address: address }
        expect(response).to have_http_status(:success)

        get "/dashboard/index", params: { address: address }
        expect(response).to have_http_status(:success)
      end

      expect(WeatherApi::Factory).to have_received(:build).once
    end
  end
end
