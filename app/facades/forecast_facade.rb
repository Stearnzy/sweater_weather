class ForecastFacade
  def self.get_weather_report(lat, long)
    data = ForecastService.complete_weather_report(lat, long)

    current_weather = CurrentWeather.new(data[:current])

    hourly_weather = data[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour)
    end

    daily_weather = data[:daily][0..4].map do |day|
      DailyWeather.new(day)
    end

    Forecast.new(current_weather, hourly_weather, daily_weather)
  end
end
