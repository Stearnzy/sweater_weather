require 'rails_helper'

describe ForecastFacade, :vcr do
  it 'can retrieve current weather data from the Forecast Service using coordinates' do
    location = 'denver,co'

    forecast = ForecastFacade.get_weather_report(location)

    expect(forecast).to be_a Forecast
    expect(forecast).to have_attributes(current_weather: CurrentWeather)
    expect(forecast).to have_attributes(hourly_weather: Array)
    expect(forecast).to have_attributes(daily_weather: Array)
  end

  it 'trip_future_weather' do
    unix_eta = 1611104795
    destination = 'Pueblo, CO'

    forecast = ForecastFacade.trip_future_weather(unix_eta, destination)
    expect(forecast).to be_an HourlyWeather

    expect(forecast.time.to_time.to_i).to be <= unix_eta
  end

  it '#weather_at_location' do
    location = 'Pueblo, CO'
    data = ForecastFacade.weather_at_location(location)

    expect(data).to be_a Hash
    expect(data).to have_key(:lat)
    expect(data).to have_key(:lon)
    expect(data).to have_key(:timezone)
    expect(data).to have_key(:timezone_offset)
    expect(data).to have_key(:current)
    expect(data).to have_key(:hourly)
    expect(data).to have_key(:daily)
  end

  it '#current_weather' do
    location = 'Pueblo, CO'
    data = ForecastFacade.weather_at_location(location)

    current = ForecastFacade.current_weather(data)
    expect(current).to be_a CurrentWeather
  end

  it '#hourly_weather' do
    location = 'Pueblo, CO'
    data = ForecastFacade.weather_at_location(location)

    hourly = ForecastFacade.hourly_weather(data)
    expect(hourly).to be_an Array
    expect(hourly[0]).to be_a HourlyWeather
  end

  it '#daily_weather' do
    location = 'Pueblo, CO'
    data = ForecastFacade.weather_at_location(location)

    daily = ForecastFacade.daily_weather(data)
    expect(daily).to be_an Array
    expect(daily[0]).to be_a DailyWeather
  end
end
