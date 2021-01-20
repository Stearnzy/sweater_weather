require 'rails_helper'

describe 'Bing Image' do
  it 'can retrieve a background image based on city', :vcr do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    get '/api/v1/backgrounds?location=denver,co', headers: headers
    expect(response).to be_successful
    image_data = JSON.parse(response.body, symbolize_names: true)
    expect(image_data).to be_a Hash
    expect(image_data).to have_key(:data)

    expect(image_data[:data]).to be_a Hash
    expect(image_data[:data]).to have_key(:id)
    expect(image_data[:data][:id]).to eq(nil)

    expect(image_data[:data]).to have_key(:type)
    expect(image_data[:data][:type]).to be_a String
    expect(image_data[:data][:type]).to eq('image')

    expect(image_data[:data]).to have_key(:attributes)
    expect(image_data[:data][:attributes]).to be_a Hash
    expect(image_data[:data][:attributes]).to have_key(:location)
    expect(image_data[:data][:attributes][:location]).to be_a String
    expect(image_data[:data][:attributes][:location]).to_not be_empty

    expect(image_data[:data][:attributes]).to have_key(:image_url)
    expect(image_data[:data][:attributes][:image_url]).to be_a String
    expect(image_data[:data][:attributes][:image_url]).to_not be_empty

    expect(image_data[:data][:attributes]).to have_key(:credit)
    expect(image_data[:data][:attributes][:credit]).to be_a Hash

    expect(image_data[:data][:attributes][:credit]).to have_key(:supplier)
    expect(image_data[:data][:attributes][:credit][:supplier]).to be_a String
    expect(image_data[:data][:attributes][:credit][:supplier]).to_not be_empty

    expect(image_data[:data][:attributes][:credit]).to have_key(:source)
    expect(image_data[:data][:attributes][:credit][:source]).to be_a String
    expect(image_data[:data][:attributes][:credit][:source]).to_not be_empty
  end

  # SAD
  it 'errors when entry is blank', :vcr do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    get '/api/v1/backgrounds?location=', headers: headers
    expect(response).to_not be_successful

    error_message = JSON.parse(response.body, symbolize_names: true)
    expect(error_message).to be_a Hash

    expect(error_message).to have_key(:error)
    expect(error_message[:error]).to eq('Entry blank, please enter in a valid location')
  end
end
