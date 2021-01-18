require 'rails_helper'

describe 'OpenWeather Forecast', :vcr do
  it 'can retrieve weather data' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    get '/api/v1/forecast?location=denver,co', headers: headers

    expect(response).to be_successful

    weather_data = JSON.parse(response.body, symbolize_names: true)
    expect(weather_data).to be_a Hash
    expect(weather_data).to have_key(:data)
    expect(weather_data[:data]).to be_a Hash

    expect(weather_data[:data]).to have_key(:id)
    expect(weather_data[:data][:id]).to eq(nil)

    expect(weather_data[:data]).to have_key(:type)
    expect(weather_data[:data][:type]).to be_a String
    expect(weather_data[:data][:type]).to eq('forecast')

    expect(weather_data[:data]).to have_key(:attributes)
    expect(weather_data[:data][:attributes]).to be_a Hash
    expect(weather_data[:data][:attributes]).to have_key(:current_weather)
    expect(weather_data[:data][:attributes]).to have_key(:daily_weather)
    expect(weather_data[:data][:attributes]).to have_key(:hourly_weather)

    expect(weather_data[:data][:attributes][:current_weather]).to be_a Hash
    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:datetime)
    expect(weather_data[:data][:attributes][:current_weather][:datetime]).to be_a String

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(weather_data[:data][:attributes][:current_weather][:sunrise]).to be_a String

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:sunset)
    expect(weather_data[:data][:attributes][:current_weather][:sunset]).to be_a String

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(weather_data[:data][:attributes][:current_weather][:temperature]).to be_a Float

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(weather_data[:data][:attributes][:current_weather][:feels_like]).to be_a Float

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(weather_data[:data][:attributes][:current_weather][:humidity]).to be_a Numeric

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(weather_data[:data][:attributes][:current_weather][:uvi]).to be_a Numeric

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(weather_data[:data][:attributes][:current_weather][:visibility]).to be_a Numeric

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:conditions)
    expect(weather_data[:data][:attributes][:current_weather][:conditions]).to be_a String

    expect(weather_data[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(weather_data[:data][:attributes][:current_weather][:icon]).to be_a String


    expect(weather_data[:data][:attributes][:daily_weather]).to be_an Array
    expect(weather_data[:data][:attributes][:daily_weather].length).to eq(5)
    expect(weather_data[:data][:attributes][:daily_weather][0]).to be_a Hash

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:date)
    expect(weather_data[:data][:attributes][:daily_weather][0][:date]).to be_a String

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
    expect(weather_data[:data][:attributes][:daily_weather][0][:sunrise]).to be_a String

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
    expect(weather_data[:data][:attributes][:daily_weather][0][:sunset]).to be_a String

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
    expect(weather_data[:data][:attributes][:daily_weather][0][:max_temp]).to be_a Float

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
    expect(weather_data[:data][:attributes][:daily_weather][0][:min_temp]).to be_a Float

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:conditions)
    expect(weather_data[:data][:attributes][:daily_weather][0][:conditions]).to be_a String

    expect(weather_data[:data][:attributes][:daily_weather][0]).to have_key(:icon)
    expect(weather_data[:data][:attributes][:daily_weather][0][:icon]).to be_a String


    expect(weather_data[:data][:attributes][:hourly_weather]).to be_an Array
    expect(weather_data[:data][:attributes][:hourly_weather].length).to eq(8)
    expect(weather_data[:data][:attributes][:hourly_weather][0]).to be_a Hash

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:time)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:time]).to be_a String

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:temperature]).to be_a Float

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:wind_speed)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:wind_speed]).to be_a String

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:wind_direction)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:wind_direction]).to be_a String

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:conditions]).to be_a String

    expect(weather_data[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
    expect(weather_data[:data][:attributes][:hourly_weather][0][:icon]).to be_a String
  end

  it 'does not contain unnecessary information' do
    VCR.use_cassette('OpenWeather_Forecast/can_retrieve_weather_data') do
      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      get '/api/v1/forecast?location=denver,co', headers: headers

      expect(response).to be_successful

      weather_data = JSON.parse(response.body, symbolize_names: true)
      expect(weather_data).to be_a Hash

      expect(weather_data[:data]).to have_key(:attributes)
      expect(weather_data[:data][:attributes]).to be_a Hash
      expect(weather_data[:data][:attributes]).to_not have_key(:minutely)

      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:dt)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:temp)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:pressure)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:dew_point)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:clouds)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:wind_speed)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:wind_deg)
      expect(weather_data[:data][:attributes][:current_weather]).to_not have_key(:weather)

      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:dt)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:temp)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:pressure)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:humidity)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:dew_point)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:wind_speed)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:wind_deg)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:weather)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:clouds)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:pop)
      expect(weather_data[:data][:attributes][:daily_weather][0]).to_not have_key(:uvi)

      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:dt)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:temp)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:feels_like)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:pressure)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:humidity)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:dew_point)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:uvi)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:clouds)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:visibility)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:wind_deg)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:pop)
      expect(weather_data[:data][:attributes][:hourly_weather][0]).to_not have_key(:weather)
    end
  end
end
