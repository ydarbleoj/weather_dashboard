require 'rails_helper'

RSpec.describe GeocoderResponse do
  context "when response is valid" do
    let(:valid_result) do
      double(
        "Geocoder::Result",
        latitude: 45.5202471,
        longitude: -122.674194,
        address: "2808 SE 59th ave",
        city: "Portland",
        state: nil,
        country: "USA",
        postal_code: "97206"
      )
    end

    before do
      @described_class = described_class.new(valid_result)
    end

    it "is valid" do
      expect(@described_class.valid?).to be_truthy
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
      expect(@described_class.state).to be_nil
    end

    it "returns the country" do
      expect(@described_class.country).to eq("USA")
    end

    it "returns the postal code" do
      expect(@described_class.postal_code).to eq("97206")
    end
  end

  context "when response is invalid" do
    let(:invalid_result) do
      double(
        "Geocoder::Result",
        latitude: nil,
        longitude: nil,
        address: nil,
        city: nil,
        state: nil,
        country: nil,
        postal_code: nil
      )
    end

    before do
      @described_class = described_class.new(invalid_result)
    end

    it "is invalid" do
      expect(@described_class.valid?).to be_falsey
    end
  end
end