class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(travel_time, weather_at_destination, origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = time_to_words(travel_time)
    @weather_at_eta = temp_and_conditions(weather_at_destination)
  end

  def time_to_words(travel_time)
    if travel_time != 'Impossible'
      split = travel_time.split(':').map { |unit| unit.to_i }
      if split[0] == 0
        "#{split[1]} minutes"
      elsif split[0] == 1
        "#{split[0]} hour, #{split[1]} minutes"
      else
        "#{split[0]} hours, #{split[1]} minutes"
      end
    else
      'Impossible'
    end
  end

  def temp_and_conditions(weather_at_destination)
    if weather_at_destination.nil?
      {}
    else
      { "temperature": weather_at_destination.temperature,
        "conditions": weather_at_destination.conditions }
    end
  end
end
