class GeocoderResponse
  attr_reader :result

  # This is typically the result from a geocoding service like Geocoder::Result::Google or similar.
  #
  # @param result [Object] The result object from a geocoding service.
  def initialize(result)
    @result = result
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

  def state
    @result.state
  end

  def postal_code
    @result.postal_code
  end

  def country
    @result.country
  end

  def formatted_address
    "#{address}, #{city}, #{state} #{postal_code}, #{country}"
  end
end
