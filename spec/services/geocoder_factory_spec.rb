require "rails_helper"

RSpec.describe GeocoderFactory do
  describe ".build" do
    context "when the build is successful" do
      before do
        @address = "Portland, OR"
      end

      it "returns a GeocoderResponse object" do
        VCR.use_cassette("geocoder/success/city_state") do
          result = described_class.build(@address)

          expect(result).to be_a(GeocoderResponse)

          expect(result.longitude).to be_present
          expect(result.latitude).to be_present
          expect(result.address).to be_present
          expect(result.city).to be_present
          expect(result.state).to be_present
          expect(result.country).to be_present
          expect(result.postal_code).to be_empty
        end
      end
    end

    context "when the build fails" do
      before do
        @address = "Invalid Address"
      end

      it "returns nil" do
        VCR.use_cassette("geocoder/failure/invalid_address") do
          result = described_class.build(@address)

          expect(result).to be_nil
        end
      end
    end
  end
end
