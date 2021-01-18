class ForecastFacade
  def self.get_weather_report(location)
    map_data = MapquestFacade.location_to_coordinates(location)

    weather_data = ForecastService.complete_weather_report(map_data.lat, map_data.long)

    current_weather = CurrentWeather.new(weather_data[:current])

    hourly_weather = weather_data[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour)
    end

    daily_weather = weather_data[:daily][0..4].map do |day|
      DailyWeather.new(day)
    end

    Forecast.new(current_weather, hourly_weather, daily_weather)
  end
end
