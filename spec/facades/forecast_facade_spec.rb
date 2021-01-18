require 'rails_helper'

describe ForecastFacade do
  it 'can retrieve current weather data from the Forecast Service using coordinates' do
    # VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
    #   lat = 39.738453
    #   long = -104.984853

    #   data = ForecastFacade.get_weather_report(lat, long)
    #   expect(data).to be_a CurrentWeather
    #   expect(data.datetime).to be_a Time
    #   expect(data.sunrise).to be_a Time
    #   expect(data.sunset).to be_a Time
    #   expect(data.temperature).to be_a Numeric
    #   expect(data.feels_like).to be_a Numeric
    #   expect(data.humidity).to be_a Numeric
    #   expect(data.uvi).to be_a Numeric
    #   expect(data.visibility).to be_a Numeric
    #   expect(data.conditions).to be_a String
    #   expect(data.icon).to be_a String
    # end
  end
end