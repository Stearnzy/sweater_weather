class DestinationCity
  attr_reader :destination, :dest_city, :dest_state

  def initialize(data)
    @dest_city = data[:route][:locations][1][:adminArea5]
    @dest_state = data[:route][:locations][1][:adminArea3]
    @destination = "#{@dest_city}, #{@dest_state}"
  end
end
