class ForecastFacade
  def self.get_weather_report(location)
    data = weather_at_location(location)
    Forecast.new(current_weather(data), hourly_weather(data), daily_weather(data))
  end

  def self.trip_future_weather(unix_eta, destination)
    data = weather_at_location(destination)
    hourly_weather(data).select do |hour|
      hour.time.to_time.to_i <= unix_eta
    end.last
  end

  def self.weather_at_location(location)
    map_data = MapquestFacade.location_to_coordinates(location)
    ForecastService.complete_weather_report(map_data.lat, map_data.long)
  end

  def self.current_weather(weather_data)
    CurrentWeather.new(weather_data[:current])
  end

  def self.hourly_weather(weather_data)
    weather_data[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def self.daily_weather(weather_data)
    weather_data[:daily][0..4].map do |day|
      DailyWeather.new(day)
    end
  end
end
