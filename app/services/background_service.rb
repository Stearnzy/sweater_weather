class BackgroundService
  def self.search_for_image(location)
    response = conn.get('/v7.0/images/search') do |req|
      req.params[:q] = location
      req.params[:count] = 1
      req.params[:safeSearch] = 'strict'
      req.params[:imageType] = 'Photo'
      req.params[:color] = 'ColorOnly'
    end
    parse(response)
  end

  def self.conn
    Faraday.new(url: 'https://api.bing.microsoft.com') do |faraday|
      faraday.headers['Ocp-Apim-Subscription-Key'] = ENV['BING_KEY']
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
