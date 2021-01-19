class MunchiesFacade
  def self.restaurant_response(starting, ending, food)
    eta = MapquestFacade.arrival_time(starting, ending)
    require 'pry'; binding.pry
    # eta = Time.now + travel_time


    ending_coords = MapquestFacade.location_to_coordinates(ending)
    forecast = ForecastService.complete_weather_report(ending_coords.lat, ending_coords.long)



require 'pry'; binding.pry


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
