class MapquestFacade
  def self.location_to_coordinates(location)
    data = MapquestService.location_coordinates(location)
    Coordinates.new(data)
  end

  def self.travel_time(trip_start, trip_end)
    data = MapquestService.get_directions(trip_start, trip_end)
    TravelTime.new(data)
  end

  def self.destination_city(trip_start, trip_end)
    data = MapquestService.get_directions(trip_start, trip_end)
    DestinationCity.new(data)
  end
end
