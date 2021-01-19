require 'rails_helper'

describe 'Munchies Request' do
  it 'can return food and forecast information for a destination city' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: headers

    expect(response).to be_successful
    munchie_response = JSON.parse(response.body, symbolize_names: true)

    expect(munchie_response).to be_a Hash
    expect(munchie_response).to have_key(:data)
    expect(munchie_response[:data]).to be_a Hash

    expect(munchie_response[:data]).to have_key(:id)
    expect(munchie_response[:data][:id]).to eq(nil)

    expect(munchie_response[:data]).to have_key(:type)
    expect(munchie_response[:data][:type]).to be_a String
    expect(munchie_response[:data][:type]).to eq('munchie')

    expect(munchie_response[:data]).to have_key(:attributes)
    expect(munchie_response[:data][:attributes]).to be_a Hash
    expect(munchie_response[:data][:attributes]).to have_key(:destination_city)
    expect(munchie_response[:data][:attributes][:destination_city]).to be_a String
    expect(munchie_response[:data][:attributes][:destination_city]).to eq('Pueblo, CO')

    expect(munchie_response[:data][:attributes]).to have_key(:travel_time)
    expect(munchie_response[:data][:attributes][:travel_time]).to be_a String

    expect(munchie_response[:data][:attributes]).to have_key(:forecast)
    expect(munchie_response[:data][:attributes][:forecast]).to be_a Hash

    expect(munchie_response[:data][:attributes][:forecast]).to have_key(:summary)
    expect(munchie_response[:data][:attributes][:forecast][:summary]).to be_a String
    expect(munchie_response[:data][:attributes][:forecast][:summary]).to_not be_empty

    expect(munchie_response[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(munchie_response[:data][:attributes][:forecast][:temperature]).to be_a Numeric

    expect(munchie_response[:data][:attributes]).to have_key(:restaurant)
    expect(munchie_response[:data][:attributes][:restaurant]).to be_a Hash

    expect(munchie_response[:data][:attributes][:restaurant]).to have_key(:name)
    expect(munchie_response[:data][:attributes][:restaurant][:name]).to be_a String
    expect(munchie_response[:data][:attributes][:restaurant][:name]).to_not be_empty

    expect(munchie_response[:data][:attributes][:restaurant]).to have_key(:address)
    expect(munchie_response[:data][:attributes][:restaurant][:address]).to be_a String
    expect(munchie_response[:data][:attributes][:restaurant][:address]).to_not be_empty
  end
end
