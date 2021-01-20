require 'rails_helper'

describe 'RoadTrip', :vcr do
  before(:each) do
    origin = 'Denver, CO'
    destination = 'Pueblo, CO'
    travel_time = '01:44:22'
    unix_eta = MapquestFacade.arrival_time(origin, destination)
    @weather_at_destination = ForecastFacade.trip_future_weather(unix_eta, destination)

    @trip = RoadTrip.new(travel_time, @weather_at_destination, origin, destination)
  end

  it 'exists' do
    expect(@trip).to be_a RoadTrip
  end

  it 'has attributes' do
    expect(@trip).to have_attributes(end_city: String)
    expect(@trip).to have_attributes(start_city: String)
    expect(@trip).to have_attributes(travel_time: String)
    expect(@trip).to have_attributes(weather_at_eta: Hash)

    expect(@trip.id).to eq(nil)
    expect(@trip.start_city).to eq('Denver, CO')
    expect(@trip.end_city).to eq('Pueblo, CO')
    expect(@trip.travel_time).to eq('1 hour, 44 minutes')
    expect(@trip.weather_at_eta).to have_key(:temperature)
    expect(@trip.weather_at_eta[:temperature]).to be_a Float
    expect(@trip.weather_at_eta[:conditions]).to be_a String
  end

  it '#time_to_words' do
    expect(@trip.time_to_words('02:30:12')).to eq('2 hours, 30 minutes')
    expect(@trip.time_to_words('01:30:12')).to eq('1 hour, 30 minutes')
    expect(@trip.time_to_words('00:30:12')).to eq('30 minutes')
  end

  it '#temp_and_conditions' do
    expect(@trip.temp_and_conditions(@weather_at_destination)).to be_a Hash

    expected = {
      "temperature": @weather_at_destination.temperature,
      "conditions": @weather_at_destination.conditions
    }

    expect(@trip.temp_and_conditions(@weather_at_destination)).to eq(expected)
  end

  # SAD
  it 'time_to_words returns impossible' do
    expect(@trip.time_to_words('Impossible')).to eq('Impossible')
  end

  it 'nil weather returns empty temp_and_conditions' do
    expect(@trip.temp_and_conditions(nil)).to eq({})
  end
end
