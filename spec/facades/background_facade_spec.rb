require 'rails_helper'

describe BackgroundFacade do
  it 'returns image data for location', :vcr do
    location = 'Denver, CO'
    image = BackgroundFacade.get_image_data(location)

    expect(image).to be_a Background
    expect(image.image_url).to be_a String
    expect(image.image_url).to_not be_empty
    expect(image.source).to be_a String
    expect(image.source).to_not be_empty
    expect(image.supplier).to be_a String
    expect(image.supplier).to_not be_empty
  end
end
