class ForecastService
  def self.complete_weather_report(lat, long)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params[:lat] = lat.to_s
      req.params[:lon] = long.to_s
      req.params[:units] = 'imperial'
      req.params[:appid] = ENV['OPENWEATHER_KEY']
    end
    parse(response)
  end

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
