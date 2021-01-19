class MunchiesFacade
  def self.restaurant_response(starting, ending, food)
    eta = MapquestFacade.arrival_time(starting, ending)
    time = eta.to_i

    ending_coords = MapquestFacade.location_to_coordinates(ending)
    forecast = ForecastService.complete_weather_report(ending_coords.lat, ending_coords.long)

    dest_forecast = forecast[:hourly].detect{|hour| hour[:dt] >= time}

    forecast_description = dest_forecast[:weather][0[:description]
    forecast_temp = dest_forecast[:temp]



    # {
    #   "data": {
    #     "id": nil,
    #     "type": "munchie",
    #     "attributes": {
    #       "destination_city": "#{city}, #{state},",
    #       "travel_time": "#{time}",
    #       "forecast": {
    #         "summary": forecast_description,
    #         "temperature": forecast_temp
    #       },
    #       "restaurant": {
    #         "name": "#{restaurant.name}",
    #         "address": "#{restaurant.address}"
    #       }
    #     }
    #   }
    # }
  end

  def self.get_destination_weather()
    
  end
end
