class GeocoderFactory
  def self.build(address)
    results = Geocoder.search(address)
    result = results.first
    return if results.blank?

    response = GeocoderResponse.new(result)
    response if response.valid?
  rescue StandardError => e
    nil
  end
end
