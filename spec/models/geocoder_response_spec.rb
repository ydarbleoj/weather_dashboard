require 'rails_helper'

RSpec.describe GeocoderResponse do
  let(:mock_result) do
    double(
      "Geocoder::Result",
      latitude: 37.7749,
      longitude: -122.4194,
      address: "2808 SE 59th ave",
      city: "Portland",
      state: "OR",
      country: "USA",
      postal_code: "97206"
    )
  end

  before do
    @described_class = described_class.new(mock_result)
  end

  it "returns the latitude" do
    expect(@described_class.latitude).to eq(37.7749)
  end

  it "returns the longitude" do
    expect(@described_class.longitude).to eq(-122.4194)
  end

  it "returns the address" do
    expect(@described_class.address).to eq("2808 SE 59th ave")
  end

  it "returns the city" do
    expect(@described_class.city).to eq("Portland")
  end

  it "returns the state" do
    expect(@described_class.state).to eq("OR")
  end

  it "returns the country" do
    expect(@described_class.country).to eq("USA")
  end

  it "returns the postal code" do
    expect(@described_class.postal_code).to eq("97206")
  end

  it "returns the formatted address" do
    expect(@described_class.formatted_address).to eq("2808 SE 59th ave, Portland, OR 97206, USA")
  end
end