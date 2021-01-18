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
end
