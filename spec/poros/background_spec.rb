require 'rails_helper'

describe Background do
  before(:each) do
    VCR.use_cassette('BackgroundService/can_retrieve_image_based_on_location') do
      location = 'Denver, CO'
      data = BackgroundService.search_for_image(location)
      @image = Background.new(data)
    end
  end

  it 'exists' do
    expect(@image).to be_a Background
  end

  it 'has attributes' do
    expect(@image).to have_attributes(supplier: String)
    expect(@image).to have_attributes(source: String)
    expect(@image).to have_attributes(image_url: String)
  end
end
