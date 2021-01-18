class Forecast
  attr_reader :id,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(current, hourly, daily)
    @id = nil
    @current_weather = current
    @hourly_weather = hourly
    @daily_weather = daily
  end
end
