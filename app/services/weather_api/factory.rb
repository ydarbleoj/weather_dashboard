module WeatherApi
  class Factory
    def self.build(lat:, lon:)
      client = Client.new
      response = client.fetch(lat: lat, lon: lon)
      return response if response.error?

      handler = ResponseHandler.new(response.data)
      error_response = Response.new(error: "Invalid response from the Weather API, please try again.")

      handler.valid? ? handler : error_response
    end
  end
end
