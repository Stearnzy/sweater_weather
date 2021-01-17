class MapquestFacade
  def self.location_to_coordinates(location)
    data = MapquestService.location_coordinates(location)
    Coordinates.new(data)
  end
end