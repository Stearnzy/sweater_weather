class TravelTime
  attr_reader :time

  def initialize(data)
    @time = data[:route][:formattedTime]
  end
end
