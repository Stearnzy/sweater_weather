require 'rails_helper'

describe 'User Login' do
  it 'a registered user can log in' do
    user = User.create!("email": 'guy@example.com', "password": 'password')
    login_params = { "email": 'guy@example.com', "password": 'password' }

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to be_a Hash
    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to be_a String
    expect(parsed[:data][:id]).to eq(user.id.to_s)

    expect(parsed[:data]).to have_key(:type)
    expect(parsed[:data][:type]).to be_a String
    expect(parsed[:data][:type]).to eq('users')

    expect(parsed[:data]).to have_key(:attributes)
    expect(parsed[:data][:attributes]).to be_a Hash
    expect(parsed[:data][:attributes]).to have_key(:email)
    expect(parsed[:data][:attributes][:email]).to be_a String
    expect(parsed[:data][:attributes][:email]).to eq(user.email)

    expect(parsed[:data][:attributes]).to have_key(:api_key)
    expect(parsed[:data][:attributes][:api_key]).to be_a String
    expect(parsed[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  # SAD
  it 'throws an error if email is not valid' do
    user = User.create!("email": 'guy@example.com', "password": 'password')
    login_params = { "email": 'nottheguy@example.com', "password": 'password' }

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to be_a String
    expect(parsed[:error]).to eq('Invalid email or password')
  end

  it 'throws an error if password is not valid' do
    user = User.create!("email": 'guy@example.com', "password": 'password')
    login_params = { "email": 'guy@example.com', "password": 'nopenotright' }

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to be_a String
    expect(parsed[:error]).to eq('Invalid email or password')
  end

  it 'throws an error if email is blank' do
    user = User.create!("email": 'guy@example.com', "password": 'password')
    login_params = { "email": '', "password": 'password' }

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to be_a String
    expect(parsed[:error]).to eq('Invalid email or password')
  end

  it 'throws an error if password is blank' do
    user = User.create!("email": 'guy@example.com', "password": 'password')
    login_params = { "email": 'guy@example.com', "password": '' }

    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to be_a String
    expect(parsed[:error]).to eq('Invalid email or password')
  end
end
