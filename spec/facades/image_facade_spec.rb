require 'rails_helper'

describe ImageFacade do
  it 'returns image data for location', :vcr do
    location = 'Denver, CO'
    image = ImageFacade.get_image_data(location)

    expect(image).to be_an Image
    expect(image.id).to eq(nil)
    expect(image.location).to eq(location)

    expect(image.image_url).to be_a String
    expect(image.image_url).to_not be_empty

    expect(image.credit).to be_a Hash
    expect(image.credit).to have_key(:supplier)
    expect(image.credit[:supplier]).to be_a String
    expect(image.credit[:supplier]).to_not be_empty

    expect(image.credit).to have_key(:source)
    expect(image.credit[:source]).to be_a String
    expect(image.credit[:source]).to_not be_empty
  end
end
