require 'rails_helper'

describe '.class_methods' do
  it 'weather_search method returns parsed response based on params', :vcr do
    params = {
      lat: "39.738453",
      lon: "-104.984853"
    }
    search = WeatherService.weather_search(params)

    expect(search).to be_a(Hash)
    expect(search.keys).to eq([:lat,
                              :lon,
                              :timezone,
                              :timezone_offset,
                              :current,
                              :minutely,
                              :hourly,
                              :daily])
    expect(search[:daily]).to be_an(Array)
    expect(search[:daily].length).to eq(8)
    expect(search[:daily][0]).to be_a(Hash)
    expect(search[:daily][0].keys).to eq([:dt,
                                          :sunrise,
                                          :sunset,
                                          :temp,
                                          :feels_like,
                                          :pressure,
                                          :humidity,
                                          :dew_point,
                                          :wind_speed,
                                          :wind_deg,
                                          :weather,
                                          :clouds,
                                          :pop,
                                          :uvi])
    expect(search[:daily][0][:temp]).to be_a(Hash)
    expect(search[:daily][0][:temp][:min]).to be_a(Float)
    expect(search[:daily][0][:temp][:max]).to be_a(Float)
    expect(search[:daily][0][:feels_like][:day]).to be_a(Float)
    expect(search[:daily][0][:weather][0][:description]).to be_a(String)
    expect(search[:daily][0][:clouds]).to be_an(Integer)
  end
end
