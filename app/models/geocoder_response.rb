class GeocoderResponse
  attr_reader :result

  def initialize(result)
    @result = result
  end

  def error?
    latitude.blank? && longitude.blank?
  end

  def latitude
    @result.latitude
  end

  def longitude
    @result.longitude
  end

  def address
    @result.address
  end

  def city
    @result.city
  end

  def state
    @result.state
  end

  def country
    @result.country
  end

  def postal_code
    @result.postal_code
  end
end
