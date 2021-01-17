require 'rails_helper'

describe ForecastService, :vcr do
  it 'returns weather from coordinates' do
    lat = 39.738453
    long = -104.984853

    data = ForecastService.complete_weather_report(lat, long)
    expect(data).to be_a Hash
    expect(data).to have_key(:lat)
    expect(data).to have_key(:lon)
    expect(data).to have_key(:timezone)
    expect(data).to have_key(:timezone_offset)
    expect(data).to have_key(:current)
    expect(data).to have_key(:minutely)
    expect(data).to have_key(:hourly)
    expect(data).to have_key(:daily)

    expect(data[:lat]).to be_a Float
    expect(data[:lon]).to be_a Float
    expect(data[:timezone]).to be_a String
    expect(data[:timezone_offset]).to be_an Integer

    expect(data[:current]).to be_a Hash
    expect(data[:current]).to have_key(:dt)
    expect(data[:current][:dt]).to be_an Integer 

    expect(data[:current]).to have_key(:sunrise)
    expect(data[:current][:sunrise]).to be_an Integer 

    expect(data[:current]).to have_key(:sunset)
    expect(data[:current][:sunset]).to be_an Integer 

    expect(data[:current]).to have_key(:temp)
    expect(data[:current][:temp]).to be_a Float 

    expect(data[:current]).to have_key(:feels_like)
    expect(data[:current][:feels_like]).to be_a Float 

    expect(data[:current]).to have_key(:pressure)
    expect(data[:current][:pressure]).to be_an Integer 

    expect(data[:current]).to have_key(:humidity)
    expect(data[:current][:humidity]).to be_an Integer 

    expect(data[:current]).to have_key(:dew_point)
    expect(data[:current][:dew_point]).to be_a Float 

    expect(data[:current]).to have_key(:uvi)
    expect(data[:current][:uvi]).to be_a Float 

    expect(data[:current]).to have_key(:clouds)
    expect(data[:current][:clouds]).to be_an Integer 

    expect(data[:current]).to have_key(:visibility)
    expect(data[:current][:visibility]).to be_an Integer 

    expect(data[:current]).to have_key(:wind_speed)
    expect(data[:current][:wind_speed]).to be_a Float 

    expect(data[:current]).to have_key(:wind_deg)
    expect(data[:current][:wind_deg]).to be_an Integer 

    expect(data[:current]).to have_key(:weather)
    expect(data[:current][:weather]).to be_an Array 
    expect(data[:current][:weather][0]).to be_a Hash
    expect(data[:current][:weather][0]).to have_key(:id)
    expect(data[:current][:weather][0][:id]).to be_an Integer

    expect(data[:current][:weather][0]).to have_key(:main)
    expect(data[:current][:weather][0][:main]).to be_a String

    expect(data[:current][:weather][0]).to have_key(:description)
    expect(data[:current][:weather][0][:description]).to be_a String

    expect(data[:current][:weather][0]).to have_key(:icon)
    expect(data[:current][:weather][0][:icon]).to be_a String
  
  
    expect(data[:minutely]).to be_an Array
    expect(data[:minutely][0]).to be_a Hash
    expect(data[:minutely][0]).to have_key(:dt)
    expect(data[:minutely][0][:dt]).to be_an Integer

    expect(data[:minutely][0]).to have_key(:precipitation)
    expect(data[:minutely][0][:precipitation]).to be_an Integer


    expect(data[:hourly]).to be_an Array
    expect(data[:hourly][0]).to be_a Hash
    expect(data[:hourly][0]).to have_key(:dt)
    expect(data[:hourly][0][:dt]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:temp)
    expect(data[:hourly][0][:temp]).to be_a Float

    expect(data[:hourly][0]).to have_key(:feels_like)
    expect(data[:hourly][0][:feels_like]).to be_a Float

    expect(data[:hourly][0]).to have_key(:pressure)
    expect(data[:hourly][0][:pressure]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:humidity)
    expect(data[:hourly][0][:humidity]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:dew_point)
    expect(data[:hourly][0][:dew_point]).to be_a Float

    expect(data[:hourly][0]).to have_key(:uvi)
    expect(data[:hourly][0][:uvi]).to be_a Float

    expect(data[:hourly][0]).to have_key(:clouds)
    expect(data[:hourly][0][:clouds]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:visibility)
    expect(data[:hourly][0][:visibility]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:wind_speed)
    expect(data[:hourly][0][:wind_speed]).to be_a Float

    expect(data[:hourly][0]).to have_key(:wind_deg)
    expect(data[:hourly][0][:wind_deg]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:pop)
    expect(data[:hourly][0][:pop]).to be_an Integer

    expect(data[:hourly][0]).to have_key(:weather)
    expect(data[:hourly][0][:weather]).to be_an Array
    expect(data[:hourly][0][:weather][0]).to be_a Hash
    expect(data[:hourly][0][:weather][0]).to have_key(:id)
    expect(data[:hourly][0][:weather][0][:id]).to be_an Integer
    expect(data[:hourly][0][:weather][0]).to have_key(:main)
    expect(data[:hourly][0][:weather][0][:main]).to be_a String
    expect(data[:hourly][0][:weather][0]).to have_key(:description)
    expect(data[:hourly][0][:weather][0][:description]).to be_a String
    expect(data[:hourly][0][:weather][0]).to have_key(:icon)
    expect(data[:hourly][0][:weather][0][:icon]).to be_a String


    expect(data[:daily]).to be_an Array
    expect(data[:daily][0]).to be_a Hash
    expect(data[:daily][0]).to have_key(:dt)
    expect(data[:daily][0][:dt]).to be_an Integer

    expect(data[:daily][0]).to have_key(:sunrise)
    expect(data[:daily][0][:sunrise]).to be_an Integer

    expect(data[:daily][0]).to have_key(:sunset)
    expect(data[:daily][0][:sunset]).to be_an Integer

    expect(data[:daily][0]).to have_key(:temp)
    expect(data[:daily][0][:temp]).to be_a Hash
    expect(data[:daily][0][:temp]).to have_key(:day)
    expect(data[:daily][0][:temp][:day]).to be_a Float
    expect(data[:daily][0][:temp]).to have_key(:min)
    expect(data[:daily][0][:temp][:min]).to be_a Float
    expect(data[:daily][0][:temp]).to have_key(:max)
    expect(data[:daily][0][:temp][:max]).to be_a Float
    expect(data[:daily][0][:temp]).to have_key(:night)
    expect(data[:daily][0][:temp][:night]).to be_a Float
    expect(data[:daily][0][:temp]).to have_key(:eve)
    expect(data[:daily][0][:temp][:eve]).to be_a Float
    expect(data[:daily][0][:temp]).to have_key(:morn)
    expect(data[:daily][0][:temp][:morn]).to be_a Float

    expect(data[:daily][0]).to have_key(:feels_like)
    expect(data[:daily][0][:feels_like]).to be_a Hash
    expect(data[:daily][0][:feels_like]).to have_key(:day)
    expect(data[:daily][0][:feels_like][:day]).to be_a Float
    expect(data[:daily][0][:feels_like]).to have_key(:night)
    expect(data[:daily][0][:feels_like][:night]).to be_a Float
    expect(data[:daily][0][:feels_like]).to have_key(:eve)
    expect(data[:daily][0][:feels_like][:eve]).to be_a Float
    expect(data[:daily][0][:feels_like]).to have_key(:morn)
    expect(data[:daily][0][:feels_like][:morn]).to be_a Float

    expect(data[:daily][0]).to have_key(:pressure)
    expect(data[:daily][0][:pressure]).to be_an Integer

    expect(data[:daily][0]).to have_key(:humidity)
    expect(data[:daily][0][:humidity]).to be_an Integer

    expect(data[:daily][0]).to have_key(:dew_point)
    expect(data[:daily][0][:dew_point]).to be_a Float

    expect(data[:daily][0]).to have_key(:wind_speed)
    expect(data[:daily][0][:wind_speed]).to be_a Float

    expect(data[:daily][0]).to have_key(:wind_deg)
    expect(data[:daily][0][:wind_deg]).to be_an Integer

    expect(data[:daily][0]).to have_key(:weather)
    expect(data[:daily][0][:weather]).to be_an Array
    expect(data[:daily][0][:weather][0]).to be_a Hash
    expect(data[:daily][0][:weather][0]).to have_key(:id)
    expect(data[:daily][0][:weather][0][:id]).to be_an Integer
    expect(data[:daily][0][:weather][0]).to have_key(:main)
    expect(data[:daily][0][:weather][0][:main]).to be_a String
    expect(data[:daily][0][:weather][0]).to have_key(:description)
    expect(data[:daily][0][:weather][0][:description]).to be_a String
    expect(data[:daily][0][:weather][0]).to have_key(:icon)
    expect(data[:daily][0][:weather][0][:icon]).to be_a String

    expect(data[:daily][0]).to have_key(:clouds)
    expect(data[:daily][0][:clouds]).to be_an Integer
    
    expect(data[:daily][0]).to have_key(:pop)
    expect(data[:daily][0][:pop]).to be_a Float

    expect(data[:daily][0]).to have_key(:uvi)
    expect(data[:daily][0][:uvi]).to be_a Float
  end
end