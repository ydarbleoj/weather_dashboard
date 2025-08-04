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

    def error?
      current_empty? || forecastday_empty?
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

    def current_empty?
      current.blank? && current_temp.blank?
    end

    def forecastday_empty?
      forecast.blank? && forecastday.blank?
    end
  end
end
