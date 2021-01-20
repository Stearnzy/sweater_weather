class RoadTripFacade
  def self.new_road_trip(origin, destination)
    travel_time = MapquestFacade.travel_time(origin, destination)
    unix_eta = MapquestFacade.arrival_time(origin, destination).to_i
    weather_at_destination = ForecastFacade.trip_future_weather(unix_eta, destination)

    RoadTrip.new(travel_time, unix_eta, weather_at_destination, origin, destination)
  end
end
