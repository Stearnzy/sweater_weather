require 'rails_helper'

describe 'TravelTime' do
  before(:each) do
    VCR.use_cassette('MapquestService/returns_data_between_two_locations') do
      trip_start = 'denver,co'
      trip_end = 'pueblo,co'
      data = MapquestService.get_directions(trip_start, trip_end)

      @travel_time = TravelTime.new(data)
    end
  end

  it 'exists' do
    expect(@travel_time).to be_a TravelTime
  end

  it 'has attributes' do
    expect(@travel_time).to have_attributes(time: String)
  end
end
