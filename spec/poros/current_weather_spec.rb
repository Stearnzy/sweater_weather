require 'rails_helper'

describe 'CurrentWeather' do
  before(:each) do
    VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
      lat = 39.738453
      long = -104.984853

      data = ForecastService.complete_weather_report(lat, long)
      @weather = CurrentWeather.new(data[:current])
    end
  end

  it 'exists' do
    expect(@weather).to be_a CurrentWeather
  end

  it 'has attributes' do
    expect(@weather).to have_attributes(datetime: Time)
    expect(@weather).to have_attributes(sunrise: Time)
    expect(@weather).to have_attributes(sunset: Time)
    expect(@weather).to have_attributes(sunset: Time)
    expect(@weather).to have_attributes(temperature: Numeric)
    expect(@weather).to have_attributes(feels_like: Numeric)
    expect(@weather).to have_attributes(humidity: Numeric)
    expect(@weather).to have_attributes(uvi: Numeric)
    expect(@weather).to have_attributes(visibility: Numeric)
    expect(@weather).to have_attributes(conditions: String)
    expect(@weather).to have_attributes(icon: String)
  end
end
