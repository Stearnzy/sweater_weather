require 'rails_helper'

describe 'OpenWeather Forecast', :vcr do
  it 'can retrieve weather data' do
    get "/api/v1/forecast?location=denver,co"
  end
end
