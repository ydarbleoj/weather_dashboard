module WeatherApi
  class Response
    attr_reader :data, :error, :code

    def initialize(data: nil, error: nil, code: nil)
      @data = data
      @error = error
      @code = code
    end

    def error?
      error.present?
    end
  end
end