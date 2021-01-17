class MapquestFacade
  def self.location_to_coordinates(location)
    # If location is valid,
      data = MapquestService.location_coordinates(location)
      coordinates = Coordinates.new(data)

      
    # else
      # error message
    # end
  end
end