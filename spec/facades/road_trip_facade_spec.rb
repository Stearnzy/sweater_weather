require 'rails_helper'

describe 'RoadTripFacade', :vcr do
  it 'gets road trip information' do
    origin = 'Denver, CO'
    destination = 'Pueblo, CO'

    trip = RoadTripFacade.new_road_trip(origin, destination)

    expect(trip).to be_a RoadTrip
    expect(trip).to have_attributes(start_city: String)
    expect(trip).to have_attributes(end_city: String)
    expect(trip).to have_attributes(travel_time: String)
    expect(trip).to have_attributes(weather_at_eta: Hash)
  end
end
