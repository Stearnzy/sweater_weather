class MapquestService
  def self.location_coordinates(location_input)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:location] = "#{location_input}"
    end

    parse(response)
  end

  def self.get_directions(trip_start, trip_end)
    response = conn.get('/directions/v2/route') do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
      req.params[:from] = "#{trip_start}"
      req.params[:to] = "#{trip_end}"
    end

    parse(response)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
