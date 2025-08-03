class GeocoderFactory
  def self.build(address)
    results = Geocoder.search(address)
    result = results.first
    return if results.blank?

    response = GeocoderResponse.new(result)
    response if response.valid?
  rescue StandardError => e
    Rails.logger.error("Geocoding error: #{e.message}")
    nil
  end
end
