require 'rails_helper'

describe 'DailyWeather' do
  before(:each) do
    VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
      lat = 39.738453
      long = -104.984853

      data = ForecastService.complete_weather_report(lat, long)
      @weather = data[:daily][0..4].map do |daily_report|
        DailyWeather.new(daily_report)
      end
    end
  end

  it 'exists' do
    expect(@weather).to be_an Array
    expect(@weather.length).to eq(5)
    expect(@weather[0]).to be_a DailyWeather
  end

  it 'has attributes' do
    expect(@weather[0]).to have_attributes(date: String)
    expect(@weather[0]).to have_attributes(sunrise: Time)
    expect(@weather[0]).to have_attributes(sunset: Time)
    expect(@weather[0]).to have_attributes(max_temp: Float)
    expect(@weather[0]).to have_attributes(min_temp: Float)
    expect(@weather[0]).to have_attributes(conditions: String)
    expect(@weather[0]).to have_attributes(icon: String)
  end
end