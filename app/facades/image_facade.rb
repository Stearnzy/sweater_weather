class ImageFacade
  def self.get_image_data(location)
    data = ImageService.search_for_image(location)
    Image.new(data, location)
  end
end
