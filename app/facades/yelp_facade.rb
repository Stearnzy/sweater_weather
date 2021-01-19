class YelpFacade
  def self.get_restaurant(location, food)
    data = YelpService.business_by_location(location, food)
    Restaurant.new(data)
  end
end
