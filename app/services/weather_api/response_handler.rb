module WeatherApi
  class ResponseHandler
    def initialize(response)
      @response = response
    end

    def current_weather
      Weather.new(current_day, current_temp: current_temp)
    end

    def forecast_weather
      forecastday[1..-1].map { |day| Weather.new(day) }
    end

    def valid?
      forecastday? && current?
    end

    private

    def current
      @response["current"]
    end

    def current_temp
      current["temp_f"]
    end

    def current_day
      forecastday.first
    end

    def forecast
      @response["forecast"]
    end

    def forecastday
      forecast["forecastday"]
    end

    def current?
      current.present? && current_temp.present?
    end

    def forecastday?
      forecast.present? && forecastday.present?
    end
  end
end
