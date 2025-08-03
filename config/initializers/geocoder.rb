Geocoder.configure(
  lookup: :opencagedata,
  api_key: ENV['OPEN_CAGE_DATA_API_KEY'],
  ip_lookup: :ipapi,
  units: :mi,
  timeout: 10,
  cache: nil,
  opencagedata: {
    email: "weather_dashboard@email.com",
    headers: { "User-Agent" => "Weather Dashboard ('weather_dashboard@email.com'})" }
  }
)
