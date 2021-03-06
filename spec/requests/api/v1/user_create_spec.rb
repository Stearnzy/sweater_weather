require 'rails_helper'

describe 'User Create' do
  it 'can create a user', :vcr do
    User.delete_all
    expect(User.count).to eq(0)

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': 'guy@email.com',
      'password': 'password',
      'password_confirmation': 'password'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to be_a Hash

    expect(parsed_response[:data]).to have_key(:id)
    expect(parsed_response[:data][:id]).to be_a String
    expect(parsed_response[:data][:id]).to_not be_empty

    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data][:type]).to be_a String
    expect(parsed_response[:data][:type]).to_not be_empty
    expect(parsed_response[:data][:type]).to eq('users')

    expect(parsed_response[:data]).to have_key(:attributes)
    expect(parsed_response[:data][:attributes]).to be_a Hash
    expect(parsed_response[:data][:attributes]).to have_key(:email)
    expect(parsed_response[:data][:attributes][:email]).to be_a String
    expect(parsed_response[:data][:attributes][:email]).to eq('guy@email.com')
    expect(parsed_response[:data][:attributes]).to have_key(:api_key)
    expect(parsed_response[:data][:attributes][:api_key]).to be_a String
    expect(parsed_response[:data][:attributes][:api_key]).to_not be_empty

    expect(User.count).to eq(1)
  end

  # SAD
  it 'gives an error if email is taken' do
    user_1 = create(:user, email: 'guy@email.com')

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': 'guy@email.com',
      'password': 'password',
      'password_confirmation': 'password'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:error)
    expect(parsed_response[:error]).to be_a String
    expect(parsed_response[:error]).to eq('Email has already been taken')
  end

  it 'gives an error if passwords do not match' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': 'guy@email.com',
      'password': 'password',
      'password_confirmation': 'what'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:error)
    expect(parsed_response[:error]).to be_a String

    expect(parsed_response[:error]).to eq("Password_confirmation doesn't match Password")
  end

  it 'gives an error if password confirm is empty' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': 'guy@email.com',
      'password': 'password',
      'password_confirmation': ''
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:error)
    expect(parsed_response[:error]).to be_a String
    expect(parsed_response[:error]).to eq("Password_confirmation doesn't match Password")
  end

  it 'gives an error if email is empty' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': '',
      'password': 'password',
      'password_confirmation': 'password'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:error)
    expect(parsed_response[:error]).to be_a String
    expect(parsed_response[:error]).to eq("Email can't be blank")
  end

  it 'gives an error if password fields are both empty' do
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    body = {
      'email': 'guy@email.com',
      'password': '',
      'password_confirmation': ''
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(body)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:error)
    expect(parsed_response[:error]).to be_a String
    expect(parsed_response[:error]).to eq("Password can't be blank")
  end
end
