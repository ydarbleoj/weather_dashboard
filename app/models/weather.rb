class Weather
  def initialize(forecast, current_temp: nil)
    @forecast = forecast
    @current_temp = current_temp
  end

  def date
    @forecast["date"]
  end

  def temperature
    @current_temp || day["avgtemp_f"]
  end

  def high
    day["maxtemp_f"]
  end

  def low
    day["mintemp_f"]
  end

  private

  def day
    @forecast["day"]
  end
end
