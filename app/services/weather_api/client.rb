require "httparty"

module WeatherApi
  class Client
    include HTTParty
    base_uri "https://api.weatherapi.com/v1"

    def initialize
      @api_key = ENV["WEATHER_API_API_KEY"]
    end

    def fetch(lat:, lon:)
      query = {
        key: @api_key,
        q: "#{lat},#{lon}",
        days: 4,
        aqi: "no",
        alerts: "no"
      }

      response = self.class.get("/forecast.json", query: query)
      parse_response(response)
    rescue HTTParty::Error => e
      Response.new(error: response.message, code: response.code)
    end

    private

    def parse_response(response)
      if response.success?
        Response.new(data: response.parsed_response)
      else
        Response.new(error: response.message, code: response.code)
      end
    end
  end
end
