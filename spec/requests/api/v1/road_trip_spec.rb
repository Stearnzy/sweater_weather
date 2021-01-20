require 'rails_helper'

describe 'Road Trip Create', :vcr do
  before(:each) do
    @user = User.create!(
      email: 'zach@example.com',
      password: 'password',
      password_confirmation: 'password',
      api_key: 'abcdefg1234567'
    )

    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  it 'can check if the api_key is correct' do
    body = {
      "origin": 'Denver,CO',
      "destination": 'Pueblo,CO',
      "api_key": @user.api_key.to_s
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(body)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a Hash

    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to eq(nil)

    expect(parsed[:data]).to have_key(:type)
    expect(parsed[:data][:type]).to be_a String
    expect(parsed[:data][:type]).to eq('road_trip')

    expect(parsed[:data]).to have_key(:attributes)
    expect(parsed[:data][:attributes]).to be_a Hash

    expect(parsed[:data][:attributes]).to have_key(:start_city)
    expect(parsed[:data][:attributes][:start_city]).to be_a String
    expect(parsed[:data][:attributes][:start_city]).to eq('Denver,CO')

    expect(parsed[:data][:attributes]).to have_key(:end_city)
    expect(parsed[:data][:attributes][:end_city]).to be_a String
    expect(parsed[:data][:attributes][:end_city]).to eq('Pueblo,CO')

    expect(parsed[:data][:attributes]).to have_key(:travel_time)
    expect(parsed[:data][:attributes][:travel_time]).to be_a String
    expect(parsed[:data][:attributes][:travel_time]).to_not be_empty

    expect(parsed[:data][:attributes]).to have_key(:weather_at_eta)
    expect(parsed[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(parsed[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
    expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(parsed[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
  end
end
