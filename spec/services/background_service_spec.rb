require 'rails_helper'

describe BackgroundService do
  it 'can retrieve image based on location', :vcr do
    location = 'Denver, CO'
    data = BackgroundService.search_for_image(location)
    expect(data).to be_a Hash

    expect(data).to have_key(:_type)
    expect(data[:_type]).to be_a String
    expect(data[:_type]).to eq('Images')

    expect(data).to have_key(:value)
    expect(data[:value]).to be_an Array

    expect(data[:value][0]).to have_key(:name)
    expect(data[:value][0][:name]).to be_a String
    expect(data[:value][0][:name]).to_not be_empty

    expect(data[:value][0]).to have_key(:contentUrl)
    expect(data[:value][0][:contentUrl]).to be_a String
    expect(data[:value][0][:contentUrl]).to_not be_empty

    expect(data[:value][0]).to have_key(:hostPageDisplayUrl)
    expect(data[:value][0][:hostPageDisplayUrl]).to be_a String
    expect(data[:value][0][:hostPageDisplayUrl]).to_not be_empty
  end
end
