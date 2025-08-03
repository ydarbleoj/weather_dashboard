Geocoder.configure(
  lookup: :nominatim,
  ip_lookup: :ipapi,
  units: :mi,
  timeout: 10,
  cache: nil,
  nominatim: {
    email: "weather_dashboard@email.com",
    headers: { "User-Agent" => "Weather Dashboard ('weather_dashboard@email.com'})" }
  }
)
