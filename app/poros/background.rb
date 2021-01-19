class Background
  attr_reader :supplier, :image_url, :source

  def initialize(data)
    @supplier = data[:value][0][:name]
    @image_url = data[:value][0][:contentUrl]
    @source = data[:value][0][:hostPageDisplayUrl]
  end
end