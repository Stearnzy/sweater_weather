require 'rails_helper'

describe 'Forecast' do
  before(:each) do
    VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
      lat = 39.738453
      long = -104.984853

      data = ForecastService.complete_weather_report(lat, long)

      current_weather = CurrentWeather.new(data[:current])

      hourly_weather = data[:hourly][0..7].map do |hour|
        HourlyWeather.new(hour)
      end

      daily_weather = data[:daily][0..4].map do |day|
        DailyWeather.new(day)
      end

      @forecast = Forecast.new(current_weather, hourly_weather, daily_weather)
    end
  end

  it 'exists' do
    expect(@forecast).to be_a Forecast
  end

  it 'has attributes' do
    expect(@forecast).to have_attributes(current_weather: CurrentWeather)
    expect(@forecast).to have_attributes(hourly_forecast: Array)
    expect(@forecast).to have_attributes(daily_forecast: Array)
  end

  it 'CurrentWeather attribute is one object' do
    expect(@forecast.current_weather).to be_a CurrentWeather
  end

  it 'HourlyWeather attribute is an array' do
    expect(@forecast.hourly_forecast).to be_an Array
    expect(@forecast.hourly_forecast[0]).to be_a HourlyWeather
    expect(@forecast.hourly_forecast.count).to eq(8)
  end

  it 'DailyWeather attribute is an array' do
    expect(@forecast.daily_forecast).to be_an Array
    expect(@forecast.daily_forecast[0]).to be_a DailyWeather
    expect(@forecast.daily_forecast.count).to eq(5)
  end
end
