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
  end
end
