require 'rails_helper'

describe ForecastFacade do
  it 'can retrieve current weather data from the Forecast Service using coordinates' do
    VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
      lat = 39.738453
      long = -104.984853

      forecast = ForecastFacade.get_weather_report(lat, long)

      expect(forecast).to be_a Forecast
      expect(forecast).to have_attributes(current_weather: CurrentWeather)
      expect(forecast).to have_attributes(hourly_forecast: Array)
      expect(forecast).to have_attributes(daily_forecast: Array)
    end
  end
end
