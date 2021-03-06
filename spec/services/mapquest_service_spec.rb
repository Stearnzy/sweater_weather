require 'rails_helper'

describe MapquestService, :vcr do
  it 'can retrieve coordinates based on city' do
    city_input = 'Denver, CO'
    data = MapquestService.location_coordinates(city_input)
    expect(data).to be_a Hash

    expect(data).to have_key(:info)
    expect(data[:info]).to have_key(:statuscode)
    expect(data[:info][:statuscode]).to eq(0)

    expect(data).to have_key(:results)
    expect(data[:results]).to be_an Array
    expect(data[:results].first).to be_a Hash
    expect(data[:results].first).to have_key(:locations)
    expect(data[:results].first[:locations]).to be_an Array
    expect(data[:results].first[:locations].first).to be_a Hash
    expect(data[:results].first[:locations].first).to have_key(:latLng)
    expect(data[:results].first[:locations].first[:latLng]).to be_a Hash
    expect(data[:results].first[:locations].first[:latLng]).to have_key(:lat)
    expect(data[:results].first[:locations].first[:latLng][:lat]).to be_a Float
    expect(data[:results].first[:locations].first[:latLng][:lat]).to eq(39.738453)
    expect(data[:results].first[:locations].first[:latLng]).to have_key(:lng)
    expect(data[:results].first[:locations].first[:latLng][:lng]).to be_a Float
    expect(data[:results].first[:locations].first[:latLng][:lng]).to eq(-104.984853)
  end

  it 'returns data between two locations' do
    trip_start = 'Denver, CO'
    trip_end = 'Pueblo, CO'

    data = MapquestService.get_directions(trip_start, trip_end)
    expect(data).to be_a Hash
    expect(data).to have_key(:info)
    expect(data[:info]).to be_a Hash
    expect(data[:info]).to have_key(:statuscode)
    expect(data[:info][:statuscode]).to eq(0)

    expect(data).to have_key(:route)
    expect(data[:route]).to be_a Hash

    expect(data[:route]).to have_key(:distance)
    expect(data[:route][:distance]).to be_a Float

    expect(data[:route]).to have_key(:formattedTime)
    expect(data[:route][:formattedTime]).to be_a String

    expect(data[:route]).to have_key(:locations)
    expect(data[:route][:locations]).to be_an Array
    expect(data[:route][:locations][1]).to be_a Hash

    expect(data[:route][:locations][1]).to have_key(:adminArea5)
    expect(data[:route][:locations][1][:adminArea5]).to be_a String
    expect(data[:route][:locations][1][:adminArea5]).to eq('Pueblo')

    expect(data[:route][:locations][1]).to have_key(:adminArea3)
    expect(data[:route][:locations][1][:adminArea3]).to be_a String
    expect(data[:route][:locations][1][:adminArea3]).to eq('CO')
  end

  # SAD
  it 'Returns an error when empty string is entered' do
    city_input = ''
    data = MapquestService.location_coordinates(city_input)
    expect(data).to be_a Hash

    expect(data).to have_key(:info)
    expect(data[:info]).to have_key(:statuscode)
    expect(data[:info][:statuscode]).to eq(400)

    expect(data[:info]).to have_key(:messages)
    expect(data[:info][:messages]).to be_an Array
    expect(data[:info][:messages].first).to eq('Illegal argument from request: Insufficient info for location')
  end

  it 'gives an error for impossible road trips' do
    origin = 'New York, NY'
    destination = 'London, UK'

    data = MapquestService.get_directions(origin, destination)
    expect(data).to be_a Hash
    expect(data).to have_key(:info)
    expect(data[:info]).to be_a Hash
    expect(data[:info]).to have_key(:statuscode)
    expect(data[:info][:statuscode]).to eq(402)

    expect(data[:info]).to have_key(:messages)
    expect(data[:info][:messages]).to be_an Array
    expect(data[:info][:messages][0]).to be_a String
    expect(data[:info][:messages][0]).to eq('We are unable to route with the given locations.')
  end
end
