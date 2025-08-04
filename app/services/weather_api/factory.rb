module WeatherApi
  class Factory
    def self.build(lat:, lon:)
      client = Client.new
      response = client.fetch(lat: lat, lon: lon)
    end
  end
end
