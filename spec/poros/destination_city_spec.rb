require 'rails_helper'

describe 'DestinationCity' do
  before(:each) do
    VCR.use_cassette('MapquestService/returns_data_between_two_locations') do
      trip_start = 'Denver, CO'
      trip_end = 'Pueblo, CO'
      data = MapquestService.get_directions(trip_start, trip_end)

      @destination_city = DestinationCity.new(data)
    end
  end

  it 'exists' do
    expect(@destination_city).to be_a DestinationCity
  end

  it 'has attributes' do
    expect(@destination_city).to have_attributes(destination: String)
    expect(@destination_city.destination).to_not be_empty
    expect(@destination_city.destination).to eq('Pueblo, CO')
  end
end
