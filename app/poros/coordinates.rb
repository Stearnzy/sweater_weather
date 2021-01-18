class Coordinates
  attr_reader :lat, :long

  def initialize(data)
    @lat = data[:results].first[:locations].first[:latLng][:lat]
    @long = data[:results].first[:locations].first[:latLng][:lng]
  end
end