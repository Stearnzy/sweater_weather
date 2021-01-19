class BackgroundFacade
  def self.get_image_data(location)
    data = BackgroundService.search_for_image(location)
    Background.new(data)
  end
end
