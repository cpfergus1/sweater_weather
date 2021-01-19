require 'rails_helper'

describe Roadtrip, type: :poros do
  before :each do
    file_contents = File.read('./spec/fixtures/weather_location_fixture.json')
    sample_weather = JSON.parse(file_contents, symbolize_names: true)
    @sample_weather = JSON.parse(sample_weather, symbolize_names: true)

    file_contents = File.read('./spec/fixtures/roadtrip_route_fixture.json')
    @sample_route = JSON.parse(file_contents, symbolize_names: true)
  end

  it 'exists' do
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_weather, units)
    roadtrip = Roadtrip.new(@sample_route, current_day)
    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a(String)
    expect(roadtrip.end_city).to be_a(String)
    expect(roadtrip.travel_time).to be_a(String)
    expect(roadtrip.weather_at_eta).to be_a(Hash)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a(Float)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'will return impossible route if directions cannot be found' do
    @sample_route[:route][:realTime] = -1
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_weather, units)
    roadtrip = Roadtrip.new(@sample_route, current_day)
    expect(roadtrip.travel_time).to eq('Impossible Route')
  end

  it 'will return info from days if travel time is very long' do
    @sample_route[:route][:realTime] = 345_600 #4 days
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_weather, units)
    roadtrip = Roadtrip.new(@sample_route, current_day)
    expect(roadtrip.travel_time).to eq("96 hours, 00 minutes, 00 seconds")
    expect(roadtrip.weather_at_eta[:temperature]).to eq(current_day.daily_weather[3].max_temp)
  end

  it 'will return forecast out of range if travel time is very very long' do
    @sample_route[:route][:realTime] = 777_600 #9 days
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_weather, units)
    roadtrip = Roadtrip.new(@sample_route, current_day)
    expect(roadtrip.weather_at_eta[:temperature]).to eq('Out of Forecast Range')
  end
end
