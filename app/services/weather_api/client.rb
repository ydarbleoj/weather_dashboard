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
      response_handler(response)
    rescue HTTParty::Error => e
      Rails.logger.error("OpenWeather API error: #{e.message}")
      { error: e.message }
    end

    private

    def response_handler(response)
      if response.success?
        response.parsed_response
      else
        { error: response.message, code: response.code }
      end
    end
  end
end
