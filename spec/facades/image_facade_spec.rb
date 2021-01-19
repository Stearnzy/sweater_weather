require 'rails_helper'

describe ImageFacade do
  it 'returns image data for location', :vcr do
    location = 'Denver, CO'
    image = ImageFacade.get_image_data(location)

    expect(image).to be_an Image
    expect(image.image_url).to be_a String
    expect(image.image_url).to_not be_empty
    expect(image.source).to be_a String
    expect(image.source).to_not be_empty
    expect(image.supplier).to be_a String
    expect(image.supplier).to_not be_empty
  end
end
