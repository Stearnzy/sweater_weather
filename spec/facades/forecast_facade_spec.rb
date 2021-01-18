require 'rails_helper'

describe ForecastFacade do
  it 'can retrieve current weather data from the Forecast Service using coordinates', :vcr do
    location = 'denver,co'

    forecast = ForecastFacade.get_weather_report(location)

    expect(forecast).to be_a Forecast
    expect(forecast).to have_attributes(current_weather: CurrentWeather)
    expect(forecast).to have_attributes(hourly_forecast: Array)
    expect(forecast).to have_attributes(daily_forecast: Array)
  end
end
