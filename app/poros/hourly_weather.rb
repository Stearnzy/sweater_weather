class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.at(data[:dt]).strftime('%H:%M:%S')
    @temperature = data[:temp]
    @wind_speed = data[:wind_speed].to_s + ' mph'
    @wind_direction = calculate_wind_direction(data[:wind_deg])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def calculate_wind_direction(deg)
    degrees = (deg / 22.5) + 0.5
    directions = %w[N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW]
    directions[(degrees % 16)]
  end
end
