require "rails_helper"

RSpec.describe Weather do
  let(:current_temp) { 70.0 }
  let(:valid_response) do
    {
      "date" => "2023-10-01",
      "day" => {
        "avgtemp_f" => 68.0,
        "maxtemp_f" => 75.0,
        "mintemp_f" => 60.0
      }
    }
  end

  before do
    @described_class = described_class.new(valid_response, current_temp: current_temp)
  end

  context "when current temperature is provided" do
    it "returns the date" do
      expect(@described_class.date).to eq("2023-10-01")
    end

    it "returns the average temperature" do
      expect(@described_class.temperature).to eq(current_temp)
    end

    it "returns the high temperature" do
      expect(@described_class.high).to eq(75.0)
    end

    it "returns the low temperature" do
      expect(@described_class.low).to eq(60.0)
    end
  end

  context "when the current temperature is not provided" do
    let(:current_temp) { nil }

    it "returns the average temperature from the forecast" do
      expect(@described_class.temperature).to eq(68.0)
    end
  end
end
