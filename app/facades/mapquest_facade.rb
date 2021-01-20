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
    (Time.now.to_i + travel_time).to_i
  end

  def self.travel_time(origin, destination)
    data = MapquestService.get_directions(origin, destination)
    if data[:info][:statuscode] == 0
      data[:route][:formattedTime]
    else
      'Impossible'
    end
  end
end
