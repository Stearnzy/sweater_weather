require 'rails_helper'

describe 'HourlyWeather' do
  before(:each) do
    VCR.use_cassette('ForecastService/returns_weather_from_coordinates') do
      lat = 39.738453
      long = -104.984853

      data = ForecastService.complete_weather_report(lat, long)
      @weather = data[:hourly][0..7].map do |hourly_report|
        HourlyWeather.new(hourly_report)
      end
    end
  end

  it 'exists' do
    expect(@weather).to be_an Array
    expect(@weather.length).to eq(8)
    expect(@weather[0]).to be_an HourlyWeather
  end

  it 'has attributes' do
    expect(@weather[0]).to have_attributes(time: String)
    expect(@weather[0]).to have_attributes(temperature: Float)
    expect(@weather[0]).to have_attributes(wind_speed: String)
    expect(@weather[0]).to have_attributes(wind_direction: String)
    expect(@weather[0]).to have_attributes(conditions: String)
    expect(@weather[0]).to have_attributes(icon: String)
  end

  it '#calculate_wind_direction' do
    expect(@weather[0].calculate_wind_direction(349)).to eq('N')
    expect(@weather[0].calculate_wind_direction(11)).to eq('N')
    expect(@weather[0].calculate_wind_direction(12)).to eq('NNE')
    expect(@weather[0].calculate_wind_direction(33)).to eq('NNE')
    expect(@weather[0].calculate_wind_direction(34)).to eq('NE')
    expect(@weather[0].calculate_wind_direction(56)).to eq('NE')
    expect(@weather[0].calculate_wind_direction(57)).to eq('ENE')
    expect(@weather[0].calculate_wind_direction(57)).to eq('ENE')
    expect(@weather[0].calculate_wind_direction(78)).to eq('ENE')
    expect(@weather[0].calculate_wind_direction(79)).to eq('E')
    expect(@weather[0].calculate_wind_direction(101)).to eq('E')
    expect(@weather[0].calculate_wind_direction(102)).to eq('ESE')
    expect(@weather[0].calculate_wind_direction(123)).to eq('ESE')
    expect(@weather[0].calculate_wind_direction(124)).to eq('SE')
    expect(@weather[0].calculate_wind_direction(146)).to eq('SE')
    expect(@weather[0].calculate_wind_direction(147)).to eq('SSE')
    expect(@weather[0].calculate_wind_direction(168)).to eq('SSE')
    expect(@weather[0].calculate_wind_direction(169)).to eq('S')
    expect(@weather[0].calculate_wind_direction(191)).to eq('S')
    expect(@weather[0].calculate_wind_direction(192)).to eq('SSW')
    expect(@weather[0].calculate_wind_direction(213)).to eq('SSW')
    expect(@weather[0].calculate_wind_direction(214)).to eq('SW')
    expect(@weather[0].calculate_wind_direction(236)).to eq('SW')
    expect(@weather[0].calculate_wind_direction(237)).to eq('WSW')
    expect(@weather[0].calculate_wind_direction(258)).to eq('WSW')
    expect(@weather[0].calculate_wind_direction(259)).to eq('W')
    expect(@weather[0].calculate_wind_direction(281)).to eq('W')
    expect(@weather[0].calculate_wind_direction(282)).to eq('WNW')
    expect(@weather[0].calculate_wind_direction(303)).to eq('WNW')
    expect(@weather[0].calculate_wind_direction(304)).to eq('NW')
    expect(@weather[0].calculate_wind_direction(326)).to eq('NW')
    expect(@weather[0].calculate_wind_direction(327)).to eq('NNW')
    expect(@weather[0].calculate_wind_direction(348)).to eq('NNW')
  end
end