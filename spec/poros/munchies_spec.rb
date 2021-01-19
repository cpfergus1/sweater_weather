require 'rails_helper'

describe Munchies, type: :poros do
  before :each do
    file_contents = File.read('./spec/fixtures/weather_location_fixture.json')
    sample_weather = JSON.parse(file_contents, symbolize_names: true)
    @sample_weather = JSON.parse(sample_weather, symbolize_names: true)

    file_contents = File.read('./spec/fixtures/roadtrip_route_fixture.json')
    @sample_route = JSON.parse(file_contents, symbolize_names: true)

    file_contents = File.read('./spec/fixtures/business_fixture.json')
    @sample_buisness_data = JSON.parse(file_contents, symbolize_names: true)

  end

  it 'exists' do
    units = 'imperial'
    current_day = WeatherLocation.new(@sample_weather, units)
    roadtrip = Roadtrip.new(@sample_route, current_day)
    munchies = Munchies.new(@sample_buisness_data, roadtrip)
    expect(munchies).to be_a Munchies
    expect(munchies.start_city).to be_a(String)
    expect(munchies.end_city).to be_a(String)
    expect(munchies.travel_time).to be_a(String)
    expect(munchies.weather_at_eta).to be_a(Hash)
    expect(munchies.weather_at_eta[:temperature]).to be_a(Float)
    expect(munchies.weather_at_eta[:conditions]).to be_a(String)
    expect(munchies.restaurant).to be_a(Hash)
    expect(munchies.restaurant[:name]).to be_a(String)
    expect(munchies.restaurant[:address]).to be_a(String)
    expect(munchies.restaurant).to eq({name: 'Hong Kong Station',
                                       address: '6878 S Yosemite St, Centennial, CO 80112'})
  end
end
