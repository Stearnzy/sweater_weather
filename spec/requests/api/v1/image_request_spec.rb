require 'rails_helper'

describe 'Bing Image' do
  it 'can retrieve a background image based on city' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    get '/api/v1/backgrounds?location=denver,co', headers: headers

    expect(response).to be_successful

    image_data = JSON.parse(response.body, symbolize_names: true)

    require 'pry'; binding.pry
  end
end