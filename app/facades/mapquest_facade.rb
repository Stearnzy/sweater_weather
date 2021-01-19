class MapquestFacade
  def self.location_to_coordinates(location)
    # If location is valid,
      data = MapquestService.location_coordinates(location)
      coordinates = Coordinates.new(data)


    # else
      # error message
    # end
  end

  def self.arrival_time(origin, destination)
    data = MapquestService.get_directions(origin, destination)
    travel_time = data[:route][:realTime]
    Time.now.to_i + travel_time
  end

  def self.travel_time(origin, destination)
    data = MapquestService.get_directions(origin, destination)
    data[:route][:formattedTime]
  end
end
