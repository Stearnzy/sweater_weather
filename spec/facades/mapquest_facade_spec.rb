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

  it 'can get an ETA' do
    VCR.use_cassette('MapquestService/returns_data_between_two_locations') do
      origin = 'Denver, CO'
      destination = 'Pueblo, CO'

      unix_eta = MapquestFacade.arrival_time(origin, destination)

      expect(unix_eta).to be_an Integer
    end
  end

  it 'can get the travel time' do
    VCR.use_cassette('MapquestService/returns_data_between_two_locations') do
      origin = 'Denver, CO'
      destination = 'Pueblo, CO'

      travel_time = MapquestFacade.travel_time(origin, destination)

      expect(travel_time).to be_a String
      expect(travel_time).to_not be_empty
      expect(travel_time.length).to eq(8)
      expect(travel_time[2]).to eq(':')
      expect(travel_time[5]).to eq(':')
    end
  end
end
