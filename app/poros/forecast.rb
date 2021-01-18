class Forecast
  attr_reader :current_weather, :hourly_forecast, :daily_forecast

  def initialize(current, hourly, daily)
    @current_weather = current
    @hourly_forecast = hourly
    @daily_forecast = daily
  end
end
