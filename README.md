# Weather Dashboard

A Ruby on Rails application that displays current weather and forecast data for any address, caching requests that contain zipcodes.

## Requirements

- **Ruby**: 3.1.3 or higher
- **Rails**: 7.1.3 or higher
- **Bundler**: Dependency management

## Features

- **Address-based weather lookup**: Enter any address to get current weather and forecast
- **Smart caching**: Weather data cached for 30 minutes per postal code
- **Cache indicators**: Visual feedback when data is served from cache

## Architecture

Built using a factory pattern with service objects:

- **GeocoderFactory**: Converts addresses to coordinates using geocoding services
- **WeatherApi::Factory**: Fetches weather data from external weather APIs
- **Caching layer**: Rails cache with 30-minute expiration, keyed by postal code
- **VCR testing**: Recorded HTTP interactions for reliable test suite

## Setup

1. **Clone and install dependencies**:

   ```bash
   git clone <repo-url>
   cd weather_dashboard
   bundle install
   ```

2. **Configure environment variables**:

   ```bash
   cp .env.example .env
   ```

3. **Add your API keys to `.env`**:

   ```
   OPEN_CAGE_DATA_API_KEY=your_open_cage_data_api_key_here
   WEATHER_API_API_KEY=your_weather_api_key_here
   ```

4. **API Key Setup**:

   - **Weather API**: Sign up at [Weather API](https://www.weatherapi.com/) for free weather data
   - **Geocoding API**: Use [OpenCage Geocoding API](https://opencagedata.com/) for free geocoding data

5. **Run the application**:

   ```bash
   rails server
   ```

6. **Run tests**:
   ```bash
   bundle exec rspec
   ```

## Usage

1. Navigate to `http://localhost:3000`
2. Enter any address in the search bar
3. View current temperature, high / low, and a 3 day forecast
4. Notice the cache indicator when data is served from cache on subsequent requests

## Technical Notes

- Weather data is only cached for addresses with postal codes
- Cache keys are structured as `weather_response/{postal_code}`
- Non-postal code addresses (like "Portland, OR") bypass caching for fresh data
- All external API calls are wrapped in service objects for easy testing and maintenance
