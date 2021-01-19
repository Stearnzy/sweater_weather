class YelpService
  def self.business_by_location(location, search_params)
    response = conn.get('/v3/businesses/search') do |req|
      req.params[:term] = search_params
      req.params[:location] = location
      req.params[:limit] = 1
    end
    parse(response)
  end

  def self.conn
    Faraday.new('https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
