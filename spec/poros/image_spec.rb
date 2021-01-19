require 'rails_helper'

describe Image do
  before(:each) do
    VCR.use_cassette('ImageService/can_retrieve_image_based_on_location') do
      location = 'Denver, CO'
      data = ImageService.search_for_image(location)
      @image = Image.new(data, location)
    end
  end

  it 'exists' do
    expect(@image).to be_a Image
  end

  it 'has attributes' do
    expect(@image).to have_attributes(id: nil)
    expect(@image).to have_attributes(location: String)
    expect(@image).to have_attributes(image_url: String)

    expect(@image).to have_attributes(credit: Hash)
    expect(@image.credit).to have_key(:supplier)
    expect(@image.credit[:supplier]).to be_a String
    expect(@image.credit).to have_key(:source)
    expect(@image.credit[:source]).to be_a String
  end
end
