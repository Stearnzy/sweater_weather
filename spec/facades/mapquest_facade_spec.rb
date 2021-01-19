require 'rails_helper'

describe MapquestFacade do
  it 'can call the MapquestService and convert location to coordinates' do
    VCR.use_cassette('MapquestService/can_retrieve_coordinates_based_on_city') do
      location = 'Denver, CO'
      data = MapquestFacade.location_to_coordinates(location)

      expect(data).to be_a Coordinates
      expect(data).to have_attributes(lat: Float)
      expect(data).to have_attributes(long: Float)
    end
  end

  it 'can get travel time between locations' do
    VCR.use_cassette('MapquestService/returns_data_between_two_locations') do
      trip_start = 'denver,co'
      trip_end = 'pueblo,co'
      data = MapquestFacade.travel_time(trip_start, trip_end)

      expect(data).to be_a TravelTime
      expect(data).to have_attributes(time: String)
    end
  end
end
