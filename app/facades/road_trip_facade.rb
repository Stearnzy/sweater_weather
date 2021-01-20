class RoadTripFacade
  def self.new_road_trip(origin, destination)
    travel_time = MapquestFacade.travel_time(origin, destination)
    if travel_time != 'Impossible'
      unix_eta = MapquestFacade.arrival_time(origin, destination)
      weather_at_destination = ForecastFacade.trip_future_weather(unix_eta, destination)
    else
      weather_at_destination = nil
    end

    RoadTrip.new(travel_time, weather_at_destination, origin, destination)
  end
end
