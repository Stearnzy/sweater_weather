class MunchiesFacade
  def self.restaurant_response(starting, ending, food)
    

    {
      "data": {
        "id": nil,
        "type": "munchie",
        "attributes": {
          "destination_city": "#{city}, #{state},",
          "travel_time": "#{time}",
          "forecast": {
            "summary": forecast_description,
            "temperature": forecast_temp
          },
          "restaurant": {
            "name": "#{restaurant.name}",
            "address": "#{restaurant.address}"
          }
        }
      }
    }
  end

  def name
    
  end
end
