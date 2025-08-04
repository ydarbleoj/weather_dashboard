class GeocoderFactory
  def self.build(address)
    results = Geocoder.search(address, params: { countrycodes: "us" })
    result = results.first
    return if results.blank?

    response = GeocoderResponse.new(result)
    response unless response.error?
  rescue StandardError => e
    nil
  end
end
