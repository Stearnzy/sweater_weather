class Image
  attr_reader :id, :location, :image_url, :credit

  def initialize(data, location)
    @id = nil
    @location = location
    @image_url = data[:value][0][:contentUrl]
    @credit = { 
      supplier: data[:value][0][:name],
      source: data[:value][0][:hostPageDisplayUrl]
     }
  end
end
